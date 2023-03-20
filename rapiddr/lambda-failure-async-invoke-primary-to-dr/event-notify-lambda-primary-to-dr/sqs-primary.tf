resource "aws_sqs_queue" "primary_sqs_queue" {
  name                      = var.primary_sqs_queue_name
}

resource "aws_sqs_queue" "primary_sqs_queue_encryption" {
  name                    = var.primary_sqs_queue_name
  sqs_managed_sse_enabled = true
}

data "aws_iam_policy_document" "sqs_queue_policy" {
  statement {
      sid = "__owner_statement"
      effect = "Allow"

      principals  {
        type        = "AWS"
        identifiers = ["arn:aws:iam::${var.aws_account_id}:root"]
      }

      actions = ["SQS:*"]
      resources = ["arn:aws:sqs:us-west-2:${var.aws_account_id}:${var.primary_sqs_queue_name}"]
    }
  version = "2008-10-17"
}

resource "aws_sqs_queue_policy" "sqs_queue_policy" {
  queue_url = aws_sqs_queue.primary_sqs_queue.id
  policy    = data.aws_iam_policy_document.sqs_queue_policy.json
}