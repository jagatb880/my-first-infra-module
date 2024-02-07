provider "aws" {
  region = "us-east-1"
}
resource "aws_iam_user" "web_server" {
  name = "web_server_role_${var.environment_name}"
}

resource "aws_iam_access_key" "test" {
  user = aws_iam_user.web_server.name
}

resource "aws_iam_user_policy" "web_server_user_policy" {
  name = "demo_user_${var.environment_name}"
  user = aws_iam_user.web_server.name

  policy = jsonencode({
    Version = "2012-10-17"
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : ["ec2:Describe*", "iam:List*", "rds:Describe*", "s3:ListAllMyBuckets", "cognito-identity:List*", "cloudfront:Get*", "s3:GetBucketAcl", "s3:PutBucketAcl", "s3:GetObject", "s3:PutObject"]
        "Resource" : "*"
      }
    ]
    # Statement = [
    #   {
    #     Action   = ["ec2:Describe*", "iam:List*", "rds:Describe*", "s3:ListAllMyBuckets", "cognito-identity:List*", "cloudfront:Get*"]
    #     Effect   = "Allow"
    #     Resource = "*"
    #   },
    #   {
    #     "Effect" : "Allow",
    #     "Principal" : {
    #       "Service" : "cloudfront.amazonaws.com"
    #     },
    #     "Action" : "sts:AssumeRole"
    #   }
    # ]
  })
}

resource "aws_iam_policy" "web_server_policy" {
  name = "demo_iam_policy_${var.environment_name}"

  policy = jsonencode({
    Version = "2012-10-17"
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:*",
          "vpc:*",
          "s3:*",
          "cloudfront:*",
          "rds:*",
          "cognito-idp:*"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = aws_iam_user.web_server.name
  policy_arn = aws_iam_policy.web_server_policy.arn
}

data "aws_iam_policy_document" "waf_policy" {
  statement {
    actions = [
      "wafv2:GetWebACL",
      "wafv2:GetWebACLForResource",
      "wafv2:AssociateWebACL",
      "wafv2:DisassociateWebACL",
      "wafv2:PutLoggingConfiguration",
      "wafv2:UpdateWebACL",
    ]

    resources = [
      var.waf_acl_arn,
      var.api_gateway_arn,
    ]
  }
}

resource "aws_iam_policy" "waf_policy" {
  name        = "WAFPolicy"
  description = "IAM policy for WAF management"
  policy      = data.aws_iam_policy_document.waf_policy.json
}

resource "aws_iam_role" "waf_role" {
  name               = "WAFRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "waf_policy_attachment" {
  role       = aws_iam_role.waf_role.name
  policy_arn = aws_iam_policy.waf_policy.arn
}


