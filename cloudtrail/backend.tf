terraform {
  required_version = "v1.9.3"

  backend "s3" {
    bucket = "terraform"
    key    = "cloudtrail.tfstate"
    region = "ap-northeast-1"
  }
}
