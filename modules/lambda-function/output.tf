###################################################################
##################  Output: lambda function ARN   #################
###################################################################

output "lambda_function_arn" {
  description = "The ARN of the created Lambda function."
  value       = aws_lambda_function.lambda_function.arn
}
