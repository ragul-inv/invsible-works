provider "archive" {}

data "archive_file" "zip" {
  type        = "zip"
  source_dir = "${path.module}/code/"
  output_path = "${path.module}/code.zip"
}

resource "aws_lambda_function" "lambda_primary" {
  function_name     = var.primary_lambda_function_name
  filename          = data.archive_file.zip.output_path
  source_code_hash  = data.archive_file.zip.output_base64sha256
  role              = aws_iam_role.lambda_role_primary.arn
  handler           = "lambda_function.lambda_handler"
  runtime           = "python3.9"
  timeout           = "1"
  dead_letter_config {
      target_arn    = aws_sqs_queue.primary_sqs_queue.arn
  }
}