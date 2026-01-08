# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
# small network

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "example"
  cidr = "192.168.0.0/24"

  azs             = ["ap-northeast-1a", "ap-northeast-1c"]
  public_subnets  = ["192.168.0.0/28", "192.168.0.16/28"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "example"
  }
}


