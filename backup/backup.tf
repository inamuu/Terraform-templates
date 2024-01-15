resource "aws_backup_vault" "example" {
  name = "example-backup"
}

resource "aws_backup_plan" "example" {
  name = "example-backup-plan"

  rule {
    rule_name         = "daily-7days-retention"
    target_vault_name = aws_backup_vault.example.name
    schedule          = "cron(0 21 * * ? *)"

    lifecycle {
      delete_after = 2
    }
  }
}

resource "aws_backup_selection" "ec2" {
  name         = "ec2-backup-resources"
  plan_id      = aws_backup_plan.example.id
  iam_role_arn = aws_iam_role.aws_backup.arn
  resources = [
    aws_instance.example.arn
  ]

  // 本当に必要かはよく確認しましょう
  condition {
    string_equals {
      key   = "aws:ResourceTag/Backup"
      value = "true"
    }
  }
}

resource "aws_iam_role" "aws_backup" {
  name               = "example-aws-backup-role"
  assume_role_policy = data.aws_iam_policy_document.assume_aws_backup.json

  inline_policy {
    name   = "example-aws-backup-iam-pass-role"
    policy = data.aws_iam_policy_document.iam_pass_role.json
  }
}

resource "aws_iam_role_policy_attachment" "aws_backup_for_backup" {
  role       = aws_iam_role.aws_backup.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_iam_role_policy_attachment" "aws_backup_for_restores" {
  role       = aws_iam_role.aws_backup.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}

// NOTE: AWS Backupから復元する際にEC2インスタンスのIAMロールから権限引き継ぐために必要
// https://dev.classmethod.jp/articles/tsnote-backup-restore-role/
data "aws_iam_policy_document" "iam_pass_role" {
  version = "2012-10-17"
  statement {
    actions = [
      "iam:PassRole"
    ]
    resources = [
      aws_iam_role.example.arn
    ]
  }
}

data "aws_iam_policy_document" "assume_aws_backup" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
  }
}
