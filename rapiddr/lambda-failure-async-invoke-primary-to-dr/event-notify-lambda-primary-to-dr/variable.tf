variable "aws_account_id" {
	default = ""
}

variable "aws_region_primary" {
	default = "us-west-2"
}

variable "aws_region_dr" {
	default = "us-east-2"
}

variable "primary_lambda_function_name" {
	default = "inv-s3-failure-handling-tf-primary"
}

variable "dr_lambda_function_name" {
	default = "inv-s3-failure-handling-tf-dr"
}

variable "primary_sqs_queue_name" {
	default = "inv-s3-failure-handling-tf-primary"
}

variable "dr_sqs_queue_name" {
	default = "inv-s3-failure-handling-tf-dr"
}

variable "primary_sns_topic_name" {
	default = "inv-s3-failure-handling-tf-primary"
}

variable "dr_sns_topic_name" {
	default = "inv-s3-failure-handling-tf-dr"
}

variable "primary_eventbridge_pipes_name" {
	default = "inv-s3-failure-handling-tf-primary"
}

variable "dr_eventbridge_pipes_name" {
	default = "inv-s3-failure-handling-tf-primary"
}