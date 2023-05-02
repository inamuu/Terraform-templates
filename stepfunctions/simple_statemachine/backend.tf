provider "aws" {
  region                   = "ap-northeast-1"
  shared_credentials_files = ["~/.aws/credentials"]
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
