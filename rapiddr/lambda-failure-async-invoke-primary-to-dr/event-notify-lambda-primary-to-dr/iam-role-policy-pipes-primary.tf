resource "aws_iam_role" "primary_eventbridge_pipes_role" {
  name = "iam_for_eventbridge_pipes_primary"
  assume_role_policy = <<EOF
  {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Service": "pipes.amazonaws.com"
                },
                "Action": "sts:AssumeRole",
                "Condition": {
                    "StringEquals": {
                        "aws:SourceAccount": ${var.aws_account_id},
                        "aws:SourceArn": "arn:aws:pipes:${var.aws_region_primary}:${var.aws_account_id}:pipe/${var.primary_eventbridge_pipes_name}"
                    }
                }
            }
        ]
  } 
  EOF
}

resource "aws_iam_policy" "primary_sqs_pipes_source_role_policy" {
  name = "primary_sqs_pipes_source_policy"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sqs:ReceiveMessage",
                "sqs:DeleteMessage",
                "sqs:GetQueueAttributes"
            ],
            "Resource": [
                "arn:aws:sqs:${var.aws_region_primary}:${var.aws_account_id}:${var.primary_sqs_queue_name}"
            ]
        }
    ]
}
  POLICY
}

resource "aws_iam_role_policy_attachment" "primary_sqs_pipes_source_role_policy" {
  role       = aws_iam_role.primary_eventbridge_pipes_role.name
  policy_arn = aws_iam_policy.primary_sqs_pipes_source_role_policy.arn
}

resource "aws_iam_policy" "primary_sns_pipes_target_role_policy" {
  name = "primary_sns_pipes_target_policy"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sns:Publish"
            ],
            "Resource": [
                "arn:aws:sns:${var.aws_region_primary}:${var.aws_account_id}:${var.primary_sns_topic_name}"
            ]
        }
    ]
} 
  POLICY
}

resource "aws_iam_role_policy_attachment" "primary_sns_pipes_target_role_policy" {
  role       = aws_iam_role.primary_eventbridge_pipes_role.name
  policy_arn = aws_iam_policy.primary_sns_pipes_target_role_policy.arn
}