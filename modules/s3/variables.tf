###################################################################
#############   Variables required for s3 bucket    ###############
###################################################################

variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "region" {
  description = "The AWS region in which the S3 bucket will be created."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the S3 bucket."
  type        = map(string)
  default     = {}
}

variable "iam_user_name" {
  description = "The IAM user name to grant access to the S3 bucket."
  type        = string
}

# variable "objects" {
#   description = "A list of objects to upload to the S3 bucket. Each object should have keys 'key' and 'source'."
#   type        = list(object({
#     key    = string
#     source = string
#   }))
# }