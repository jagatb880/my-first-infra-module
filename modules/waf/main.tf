provider "aws" {
  region = "us-east-1"
}
resource "aws_wafv2_ip_set" "my_ipset" {
  name               = "my-ipset"
  description        = "Allow traffic from my VPC"
  scope              = "REGIONAL"
  addresses          = ["10.0.0.0/16"] // Replace with your VPC CIDR block
  ip_address_version = "IPV4"
}

resource "aws_wafv2_web_acl" "my_waf" {
  name        = "my-waf"
  description = "My Web Application Firewall"
  scope       = "REGIONAL"

  visibility_config {
    sampled_requests_enabled   = true
    cloudwatch_metrics_enabled = true
    metric_name                = "AllowFromVPC"
  }

  default_action {
    allow {}
  }

  // Define rules
  rule {
    name     = "allow-from-vpc"
    priority = 1

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.my_ipset.arn
      }
    }

    visibility_config {
      sampled_requests_enabled   = true
      cloudwatch_metrics_enabled = true
      metric_name                = "AllowFromVPC"
    }
  }
}

//Integrate WAF with API Gateway
resource "aws_wafv2_web_acl_association" "api_gateway_waf_association" {
  resource_arn = var.api_gateway_arn
  web_acl_arn  = aws_wafv2_web_acl.my_waf.arn
}

output "waf_acl_arn" {
  value = aws_wafv2_web_acl.my_waf.arn
}
