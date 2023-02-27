
### Public Subnet
resource "aws_subnet" "example-public-1a" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "example-public-1a"
  }
}

resource "aws_subnet" "example-public-1c" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "example-public-1c"
  }
}


resource "aws_subnet" "example-public-1d" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-1d"

  tags = {
    Name = "example-public-1d"
  }
}

### Private Subnet
resource "aws_subnet" "example-private-1a" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "example-private-1a"
  }
}

resource "aws_subnet" "example-private-1c" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "example-private-1c"
  }
}

resource "aws_subnet" "example-private-1d" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = "ap-northeast-1d"

  tags = {
    Name = "example-private-1d"
  }
}
