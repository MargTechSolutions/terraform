#
# Variables Configuration
#

variable "cluster-name" {
  default = "tsp-cluster"
  type    = string
}
variable "key_pair_name" {
  default = "Slimprep"
}
variable "eks_node_instance_type" {
  default = "t2.micro"
}

variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "profile" {
  description = "AWS CLI profile"
  type        = string
}
