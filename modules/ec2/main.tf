provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2-control" {
  ami           = "ami-0a3c3a20c09d6f377"
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    "Name"        = "web_server_${var.environment_name}"
    "Environment" = var.environment_name
  }
}

resource "aws_cloudwatch_metric_alarm" "ec2_cpu_alarm" {
  alarm_name          = "ec2-cpu-alarm-${aws_instance.ec2-control.id}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300" # 5 minutes
  statistic           = "Average"
  threshold           = "80" # Adjust threshold as needed

  dimensions = {
    InstanceId = aws_instance.ec2-control.id
  }

  alarm_description = "Alarm if CPU utilization is greater than or equal to 80% for 2 consecutive periods."

  alarm_actions = ["arn:aws:sns:us-east-1:708287751177:my-first-infra-sns.fifo"]

  ok_actions = ["arn:aws:sns:us-east-1:708287751177:my-first-infra-sns.fifo"]
}
