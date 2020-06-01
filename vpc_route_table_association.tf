# example
## Private
resource "aws_route_table_association" "example-private" {
  subnet_id      = aws_subnet.example-private.id
  route_table_id = aws_route_table.example-route-ngw.id
}

## Public
resource "aws_route_table_association" "example-public" {
  subnet_id      = aws_subnet.example-public.id
  route_table_id = aws_route_table.example-route-igw.id
}
