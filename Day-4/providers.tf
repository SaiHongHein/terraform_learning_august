terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.62.0"
    }
  }
}

provider "aws" {
  # Configuration options
  profile = "terraform-sandbox"
  default_tags {
    tags = {
      "Managed_by" = "Terraform"
    }
  }
  region = "ap-southeast-1"
}

 