resource "awscc_pipes_pipe" "pipe" {
  name      = var.primary_eventbridge_pipes_name
  role_arn  = aws_iam_role.primary_eventbridge_pipes_role.arn
  source    = aws_sqs_queue.primary_sqs_queue.arn
  target    = aws_sns_topic.primary_sns_topics.arn
}