resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-state-bucket"

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_acl" "terraform_state_acl" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.id
}
