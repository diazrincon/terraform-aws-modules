resource "aws_dynamodb_table" "this" {
  name         = var.bucket_name
  billing_mode = "PAY_PER_REQUEST" # Automatically scales for throughput

  attribute {
    name = "LockID"
    type = "S"
  }

  hash_key = "LockID"

  # Optional: Enable point-in-time recovery for disaster recovery purposes
  point_in_time_recovery {
    enabled = false
  }
}
