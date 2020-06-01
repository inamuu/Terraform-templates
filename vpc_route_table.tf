## Internet Gateway
resource "aws_route_table" "example-route-igw" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "example-route-igw"
  }
}

## NAT Gateway
resource "aws_route_table" "example-route-ngw" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.example-natgw.id
  }

  tags = {
    "Name" = "example-route-ngw"
  }
}

## Private Network
resource "aws_route_table" "example-route-private" {
  vpc_id = aws_vpc.example.id

  tags = {
    "Name" = "example-route-private"
  }
}
