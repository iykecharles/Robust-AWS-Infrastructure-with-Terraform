# # 4a. Create a Public Subnet 
resource "aws_subnet" "public-web-subnet" {
  vpc_id            = aws_vpc.dev-vpc.id
  cidr_block        = element(var.cidr, count.index)
  availability_zone = var.az[count.index]
  map_public_ip_on_launch = true
  count             = 3

  tags = {
    Name = var.subnets[count.index]
  }
}

# # 4b. Create a Private Subnet 
resource "aws_subnet" "private-app-subnet" {
  vpc_id            = aws_vpc.dev-vpc.id
  cidr_block        = element(var.cidr, count.index + 3)
  availability_zone = var.az[count.index]
  count             = 3

  tags = {
    Name = var.subnets[count.index + 3]
  }
}

# # 4c. Create a Public Subnet 
resource "aws_subnet" "private-db-subnet" {
  vpc_id            = aws_vpc.dev-vpc.id
  cidr_block        = element(var.cidr, count.index + 6)
  availability_zone = var.az[count.index]
  count             = 3

  tags = {
    Name = var.subnets[count.index + 6]
  }
}
