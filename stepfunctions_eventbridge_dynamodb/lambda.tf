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

### Slack Notify
resource "aws_lambda_function" "lambda_slack" {
  filename         = "lambda/slack_notify/zip/lambda.zip"
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
  source_dir  = "lambda/slack_notify/src/"
  output_path = "lambda/slack_notify/zip/lambda.zip"
}

### Preprocess
resource "aws_lambda_function" "lambda_preprocess" {
  filename         = "lambda/preprocess/zip/lambda.zip"
  function_name    = "${var.default_prefix}-${random_id.specify_id.hex}-preprocess"
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

data "archive_file" "lambda_zip_preprocess" {
  type        = "zip"
  source_dir  = "lambda/preprocess/src/"
  output_path = "lambda/preprocess/zip/lambda.zip"
}

### DoSomething
resource "aws_lambda_function" "lambda_dosomething" {
  filename         = "lambda/dosomething/zip/lambda.zip"
  function_name    = "${var.default_prefix}-${random_id.specify_id.hex}-dosomething"
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

data "archive_file" "lambda_zip_dosomething" {
  type        = "zip"
  source_dir  = "lambda/dosomething/src/"
  output_path = "lambda/dosomething/zip/lambda.zip"
}
