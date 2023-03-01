resource "aws_iam_role" "stepfunctions" {
  name = "${var.default_prefix}-${random_id.specify_id.hex}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "states.ap-northeast-1.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name = "MyStepFunctionsPolicy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect   = "Allow"
          Action   = "dynamodb:PutItem"
          Resource = aws_dynamodb_table.dynamodb_table.arn
        }
      ]
    })
  }
}
