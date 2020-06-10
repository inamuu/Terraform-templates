resource "aws_instance" "example" {
  count                   = 1
  ami                     = var.ami
  instance_type           = var.instance_type
  disable_api_termination = false
  key_name                = var.key_name
  vpc_security_group_ids  = [aws_security_group.example.id]
  subnet_id               = lookup(var.public_subnets_id, count.index % 2)

  root_block_device {
    volume_type = "gp2"
    volume_size = var.volume_size
  }

  tags = {
    Name = "example"
  }
}

resource "aws_eip" "example" {
  count    = 1
  instance = element(aws_instance.example.*.id, count.index)
  vpc      = true
}
