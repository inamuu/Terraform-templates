variable "region" {
  default = "ap-northeast-1"
}

variable "aws_account_id" {
  default = "123456789012"
}

variable "env" {
  default = "stg"
}

variable "role" {
  default = "shared"
}

//Instance1台の指定だと複数あったときに、順番の保証がないので、mapで指定するように修正したほうが良い
variable "stop_db_clusters" {
  type = map(any)
  default = {
    dev = {
      cluster  = "db-cluster-name",
      instance = "db-instance-name"
    }
  }
}
