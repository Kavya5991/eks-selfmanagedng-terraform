terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 1.13.3"
    }
  }

   required_version = ">= 0.14"

}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"

}

