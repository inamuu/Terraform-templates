provider "aws" {
  region                  = "ap-northeast-1"
  shared_credentials_file = "~/.aws/credentials"
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
