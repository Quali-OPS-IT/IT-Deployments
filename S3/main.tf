resource "aws_s3_bucket" "Quali-IT-S3" {
  bucket = var.bucket_name

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "Quali-IT-S3" {
  bucket = aws_s3_bucket.Quali-IT-S3.id

  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}
