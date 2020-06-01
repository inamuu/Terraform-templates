## Internet Gateway
resource "aws_route_table" "example-igw" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "example-igw"
  }
}

## NAT Gateway
resource "aws_route_table" "example-natgw" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.example-natgw.id
  }

  tags = {
    "Name" = "example-natgw"
  }
}
