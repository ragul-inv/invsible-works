resource "aws_sns_topic" "primary_sns_topics" {
  name            = var.primary_sns_topic_name
}

resource "aws_sns_topic_subscription" "sns_topic" {
  topic_arn = aws_sns_topic.primary_sns_topics.arn
  protocol  = "lambda"
  endpoint  = "arn:aws:lambda:${var.aws_region_dr}:${var.aws_account_id}:function:${var.dr_lambda_function_name}"
}