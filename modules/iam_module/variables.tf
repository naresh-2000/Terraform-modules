###################################################################
###########    Variables user by IAM user module    ############### 
###################################################################

variable "users" {
  type        = list(object({
    username         = string
    managed_policy_arns = list(string)
  }))
  description = "List of IAM users and their associated managed policy ARNs"
}
