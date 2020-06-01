
# example
resource "aws_subnet" "example-public-1a" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.50.0.0/26"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "example-public-1a"
  }
}

resource "aws_subnet" "example-public-1c" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.50.0.64/26"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "example-public-1c"
  }
}

resource "aws_subnet" "example-private-1a" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.50.0.128/26"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "example-private-1a"
  }
}

resource "aws_subnet" "example-private-1c" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.50.0.192/26"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "example-private-1c"
  }
}
