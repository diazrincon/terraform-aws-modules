output "backend_config" {
  value = {
    bucket         = aws_s3_bucket.this.bucket
    region         = aws_s3_bucket.this.region
    dynamodb_table = aws_dynamodb_table.this.name
  }
  description = "Backend configuration for Terraform"
}
