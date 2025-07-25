#
# EKS Cluster Resources
#  * IAM Role to allow EKS service to manage other AWS services
#  * EC2 Security Group to allow networking traffic with EKS cluster
#  * EKS Cluster
#

resource "aws_iam_role" "tsp-cluster" {
  name = "tsp-cluster-${terraform.workspace}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "tsp-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.tsp-cluster.name
}

resource "aws_iam_role_policy_attachment" "tsp-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.tsp-cluster.name
}

resource "aws_security_group" "tsp-cluster" {
  name        = "tsp-cluster-sg-${terraform.workspace}"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.tsp-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tsp-cluster-${terraform.workspace}"
  }
}

resource "aws_security_group_rule" "tsp-cluster-ingress-workstation-https" {
  cidr_blocks       = [local.workstation-external-cidr]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.tsp-cluster.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_eks_cluster" "tsp-cluster" {
  name     = var.cluster-name != "" ? var.cluster-name : "tsp-cluster-${terraform.workspace}"
  role_arn = aws_iam_role.tsp-cluster.arn

  vpc_config {
    security_group_ids = [aws_security_group.tsp-cluster.id]
    subnet_ids         = aws_subnet.tsp-vpc[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.tsp-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.tsp-cluster-AmazonEKSServicePolicy,
  ]
}
