# # #. Create nat gateway
resource "aws_nat_gateway" "nat" {
  connectivity_type = "public"
  subnet_id         = aws_subnet.public-web-subnet[0].id
  allocation_id = aws_eip.elasticip.id
}