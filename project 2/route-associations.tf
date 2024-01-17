
resource "aws_route_table_association" "public-web" {
  count = 3
  subnet_id      = aws_subnet.public-web-subnet[count.index].id
  route_table_id = aws_route_table.RT-web-public.id
}

resource "aws_route_table_association" "private-app" {
  count = 3
  subnet_id      = aws_subnet.private-app-subnet[count.index].id
  route_table_id = aws_route_table.RT-app-private.id
}

resource "aws_route_table_association" "private-db" {
  count = 3
  subnet_id      = aws_subnet.private-db-subnet[count.index].id
  route_table_id = aws_route_table.RT-db-private.id
}







/*
resource "aws_route_table_association" "public-web" {
  subnet_id      = aws_subnet.public-web-subnet[count.index].id
  route_table_id = aws_route_table.RT-web-public.id
  count = 3
}

resource "aws_route_table_association" "private-app" {
  subnet_id      = aws_subnet.private-app-subnet[count.index].id
  route_table_id = aws_route_table.RT-app-private.id
  count = 3
}

resource "aws_route_table_association" "private-db" {
  subnet_id      = aws_subnet.private-db-subnet[count.index].id
  route_table_id = aws_route_table.RT-db-private.id
  count = 3
}

*/