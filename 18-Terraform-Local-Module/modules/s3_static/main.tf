resource "aws_s3_bucket" "s3_static" {
  bucket = var.bucket_name
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "s3_public" {
  bucket                  = aws_s3_bucket.s3_static.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# resource "aws_s3_bucket_ownership_controls" "acl_test" {
#   bucket = aws_s3_bucket.s3_static.id
#   rule {
#     object_ownership = "BucketOwnerPreferred"
#   }
# }
resource "aws_s3_bucket_policy" "s3_public_read" {
  depends_on = [ aws_s3_bucket.s3_static ]
  bucket = aws_s3_bucket.s3_static.id
  policy     = <<EOF
  {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
	  "Principal": "*",
      "Action": [ "s3:*" ],
      "Resource": [
        "${aws_s3_bucket.s3_static.arn}",
        "${aws_s3_bucket.s3_static.arn}/*"
      ]
    }
  ]
}
  EOF
}

# resource "aws_s3_bucket_acl" "acl" {
#   bucket = aws_s3_bucket.s3_static.id
#   acl = "public-read"
#   depends_on = [ aws_s3_bucket_public_access_block.s3_public,aws_s3_bucket_ownership_controls.acl_test ]
# }

resource "aws_s3_object" "object" {
  bucket     = aws_s3_bucket.s3_static.id
  key        = "index.html"
  content_type = "text/html"
  source     = "${path.module}/index.html"
  depends_on = [aws_s3_bucket.s3_static]
#   acl = "public-read"
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.s3_static.id
  index_document {
    suffix = "index.html"
  }
}