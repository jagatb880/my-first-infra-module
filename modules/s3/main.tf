# modules/s3/main.tf

resource "aws_s3_bucket" "app_data" {
  bucket = "${var.environment_name}-jag-app-data"
  # ... Other S3 configurations
}

output "s3_bucket_domain" {
  value = aws_s3_bucket.app_data.bucket_regional_domain_name
}
