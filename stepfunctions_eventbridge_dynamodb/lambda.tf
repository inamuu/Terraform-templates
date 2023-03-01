variable "slack_webhook_url" {}

resource "aws_iam_role" "lambda_role" {
  name = "${var.default_prefix}-${random_id.specify_id.hex}-Lambda-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

resource "aws_iam_policy" "lambda_policy" {
  name = "${var.default_prefix}-${random_id.specify_id.hex}-Lambda-Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_policy.arn
  role       = aws_iam_role.lambda_role.name
}

resource "aws_lambda_function" "lambda_slack" {
  filename         = "lambda/zip/lambda.zip"
  function_name    = "${var.default_prefix}-${random_id.specify_id.hex}-slack-notify"
  role             = aws_iam_role.lambda_role.arn
  handler          = "main.lambda_handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "python3.9"
  timeout          = 30

  environment {
    variables = {
      slack_webhook_url = var.slack_webhook_url
    }
  }
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "lambda/src/"
  output_path = "lambda/zip/lambda.zip"
}
