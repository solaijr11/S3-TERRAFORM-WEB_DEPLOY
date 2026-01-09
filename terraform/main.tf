
# create bucket
resource "aws_s3_bucket" "web" {
  bucket = var.bucket_name
  
  lifecycle {
    prevent_destroy = true
  }
}

# bucket configuration
resource "aws_s3_bucket_website_configuration" "web" {
  bucket = aws_s3_bucket.web.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

#acl access
resource "aws_s3_bucket_public_access_block" "public" {
  bucket = aws_s3_bucket.web.id
  block_public_acls = false
  block_public_policy = false
}

# s3 bucket policy

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.web.id
#policy
 policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = "*"
      Action    = "s3:GetObject"
      Resource  = "${aws_s3_bucket.web.arn}/*"
    }]
  })
}
