resource "aws_iam_role" "lambda_role_primary" {
  name = "iam_for_lambda_primary"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "AWSLambdaBasicExecutionRolePolicy" {
  name = "AWSLambdaBasicExecutionRolePolicy_primary"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:${var.aws_region_primary}:${var.aws_account_id}:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:${var.aws_region_primary}:${var.aws_account_id}:log-group:/aws/lambda/${var.primary_lambda_function_name}:*"
            ]
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AWSLambdaBasicExecutionRole" {
  role       = aws_iam_role.lambda_role_primary.name
  policy_arn = aws_iam_policy.AWSLambdaBasicExecutionRolePolicy.arn
}

data "aws_iam_policy" "CloudWatchFullAccess" {
  arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_CloudWatchFullAccess_policy_attachment" {
  role       = aws_iam_role.lambda_role_primary.name
  policy_arn = "${data.aws_iam_policy.CloudWatchFullAccess.arn}"
}

data "aws_iam_policy" "AmazonSNSFullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_AmazonSNSFullAccess_policy_attachment" {
  role       = aws_iam_role.lambda_role_primary.name
  policy_arn = "${data.aws_iam_policy.AmazonSNSFullAccess.arn}"
}

data "aws_iam_policy" "AmazonSQSFullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_AmazonSQSFullAccess_policy_attachment" {
  role       = aws_iam_role.lambda_role_primary.name
  policy_arn = "${data.aws_iam_policy.AmazonSQSFullAccess.arn}"
}