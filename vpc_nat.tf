
## example
resource "aws_eip" "example-natgw-eip" {
  vpc = true

  tags = {
    Name = "example-natgw-eip"
  }
}

resource "aws_nat_gateway" "example-natgw" {
  allocation_id = aws_eip.example-natgw-eip.id
  subnet_id     = aws_subnet.example-public.id
  depends_on    = [aws_internet_gateway.igw]

  tags = {
    Name = "example-natgw"
  }
}
