###################################################################
############  Variables required for lambda function ##############
###################################################################

variable "region" {
  description = "AWS region where the Lambda function will be created."
}

variable "function_name" {
  description = "Name of the Lambda function."
  type        = string
}

variable "handler" {
  description = "The entry point of the Lambda function in the format of 'filename.handler'"
  type        = string
}

variable "runtime" {
  description = "The runtime for the Lambda function (e.g., 'python3.8', 'nodejs14.x')."
  type        = string
}

variable "layers" {
  description = "List of ARNs of Lambda layers to attach to the function."
  type        = list(string)
}

variable "s3_trigger_arn" {
  description = "The ARN of the S3 bucket and prefix to trigger the Lambda function."
  type        = string
}