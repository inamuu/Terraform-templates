#resource "aws_dynamodb_table" "" {
#  name         = "example-terraform-state-lock"
#  billing_mode = "PAY_PER_REQUEST"
#  hash_key     = "eventId"
#  attribute {
#    name = "LockID"
#    type = "S"
#  }
#  ttl {
#    attribute_name = "TTL"
#    enabled        = true
#  }
#}
