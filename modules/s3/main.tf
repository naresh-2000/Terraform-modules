# Module to create security group. 

###################################################################
###################  Create S3 Bucket  ############################
###################################################################

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = "public-read"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
  #   max_age_seconds = 3000
  }

  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  versioning {
    enabled = false
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${var.iam_user_name}"
        }
        Action    = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
        Resource  = [aws_s3_bucket.bucket.arn, "${aws_s3_bucket.bucket.arn}/*"]
      }
    ]
  })
}

data "aws_caller_identity" "current" {}

# Upload object to above s3 bucket 

# resource "aws_s3_bucket_object" "example_objects" {
#   for_each = { for obj in var.objects : obj.key => obj }

#   bucket = aws_s3_bucket.bucket.id
#   key    = each.value.key
#   source = each.value.source
# }