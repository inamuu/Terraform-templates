resource "aws_sns_topic" "chatbot" {
  name = "${var.default_prefix}-${random_id.specify_id.hex}"
}
