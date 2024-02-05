provider "aws" {
  region = "us-east-1"
}
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.s3_bucket_domain
    origin_id   = "S3Origin"
  }


  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = "demo-mylogs.s3.amazonaws.com"
    prefix          = "myprefix"
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3Origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = "${var.environment_name}-cloudfront"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

resource "aws_cloudwatch_metric_alarm" "cloudfront_4xx_error_alarm" {
  alarm_name          = "cloudfront-4xx-error-alarm-${aws_cloudfront_distribution.s3_distribution.id}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "4xxErrorRate"
  namespace           = "AWS/CloudFront"
  period              = "300" # 5 minutes
  statistic           = "Average"
  threshold           = "1" # Adjust threshold as needed

  dimensions = {
    DistributionId = aws_cloudfront_distribution.s3_distribution.id
  }

  alarm_description = "Alarm if 4xx error rate is greater than 1% for 2 consecutive periods."

  alarm_actions = ["arn:aws:sns:us-east-1:708287751177:my-first-infra-sns.fifo"]

  ok_actions = ["arn:aws:sns:us-east-1:708287751177:my-first-infra-sns.fifo"]
}

