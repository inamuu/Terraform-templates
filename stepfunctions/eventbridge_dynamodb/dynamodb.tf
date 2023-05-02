resource "aws_dynamodb_table" "dynamodb_table" {
  name         = "${var.default_prefix}-${random_id.specify_id.hex}-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "eventId"

  attribute {
    name = "eventId"
    type = "S"
  }
}
