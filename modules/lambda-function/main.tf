# Module to create lamda function 

###################################################################
###################  Create Lambda function  ############################
###################################################################

provider "aws" {
  region = var.region
}

resource "aws_lambda_function" "lambda_function" {
  filename      = "SuuchiGRID_ImageProcessing_AiConversion.zip"
  function_name = var.function_name
  role          = aws_iam_role.lambda.arn
  handler       = var.handler
  runtime       = var.runtime
  source_code_hash = filebase64sha256("SuuchiGRID_ImageProcessing_AiConversion.zip")
  layers = var.layers
}

resource "aws_lambda_permission" "lambda_s3_trigger_permission" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.arn
  principal     = "s3.amazonaws.com"
  source_arn    = var.s3_trigger_arn
}

resource "aws_iam_role" "lambda" {
  name = "lambda-fullaccess-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_inline_policy" {
  name        = "onclick-lambda-basic-execution"
  description = "Custom policy for Lambda function role"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        }
    ]
})
}

resource "aws_iam_policy_attachment" "lambda_s3_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = [aws_iam_role.lambda.name]
}

resource "aws_iam_policy_attachment" "lambda_lambda_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
  role       = [aws_iam_role.lambda.name]
}

resource "aws_iam_role_policy_attachment" "lambda" {
  policy_arn = aws_iam_policy.lambda_inline_policy.arn
  role       = aws_iam_role.lambda.name
}