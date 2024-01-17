terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA4BRNS6ZWLUZWF5E2"
  secret_key = "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"
}

