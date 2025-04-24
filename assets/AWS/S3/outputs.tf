output "bucket_name" {
  value = aws_s3_bucket.Bucket.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.Bucket.arn
}
output "bucket_region" {
  value = aws_s3_bucket.Bucket.region
}
output "bucket_domain_name" {
  value = aws_s3_bucket.Bucket.bucket_domain_name
}
