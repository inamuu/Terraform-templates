resource "aws_sfn_state_machine" "state_machine" {
  name     = "${var.default_prefix}-${random_id.specify_id.hex}"
  role_arn = aws_iam_role.stepfunctions.arn
  definition = templatefile("${path.module}/files/state_machine.json", {
    dynamodb_table_name = aws_dynamodb_table.dynamodb_table.name
  })
}
