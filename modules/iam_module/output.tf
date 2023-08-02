###################################################################
##################   Output: IAM user info   ######################
###################################################################

output "users_info" {
  description = "Information about the created IAM users"
  value       = aws_iam_user.users[*].arn
}
