output "bucket_arn" {
    value = aws_s3_bucket.s3_static.arn
}

output "bucket_endpoint" {
    value = aws_s3_bucket.s3_static.website_endpoint
}