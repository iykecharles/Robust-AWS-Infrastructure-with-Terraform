# # 1. Create vpc
resource "aws_vpc" "dev-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true

  tags = {
    Name = "dev-vpc"
  }
}

