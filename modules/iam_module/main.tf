# module to create IAM user and return User_arn, Access_key and Secret_key

###################################################################
#################   Create IAM user/s    ########################## 
###################################################################

resource "aws_iam_user" "users" {
  for_each = { for user in var.users : user.username => user }
  name = each.value.username
}

###################################################################
#################  Attach IAM policy    ########################### 
###################################################################

resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  for_each     = { for user in var.users : user.username => user }
  user         = aws_iam_user.users[each.key].name
  policy_arn   = each.value.managed_policy_arns
}

###################################################################
####### Generate Access and secret key for each IAM user ########## 
###################################################################

resource "aws_iam_access_key" "user_access_key" {
  for_each = aws_iam_user.users

  user = each.value.name
}

###################################################################
###########  Output - User_ARN, Access and Secret key ############# 
###################################################################

output "users_info" {
  value = [
    for username, user in aws_iam_user.users : {
      username     = user.name,
      user_arn     = user.arn,
      access_key   = aws_iam_access_key.user_access_key[username].id,
      secret_key   = aws_iam_access_key.user_access_key[username].secret,
      policy_arns  = var.users[username].managed_policy_arns,
    }
  ]
}
