
# example
resource "aws_subnet" "example-private" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "example-private"
  }
}

resource "aws_subnet" "example-public" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "example-public"
  }
}
