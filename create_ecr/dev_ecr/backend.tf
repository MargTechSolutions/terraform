terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = "ca-central-1"
}

#backend
terraform {
  backend "s3" {
    region               = "us-west-2"
    key                  = "ecr/terraform.tfstate"
    bucket               = "margterraform"
  }
}