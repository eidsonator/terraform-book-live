provider "aws" {
  region = "us-east-2"
}

resource "aws_cloudwatch_metric_alarm" "account-billing-alarm" {
  alarm_name = "account-billing-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "EstimatedCharges"
  namespace = "AWS/Billing"
  period = 21600
  statistic = "Average"
  threshold = 1
  alarm_description = "Billing alarm by account"
  alarm_actions = ["arn:aws:sns:us-east-2:664036491688:SnsBilling"]

  dimensions = {
    Currency = "USD"
    LinkedAccount = "664036491688"
  }
}

terraform {
  backend "s3" {
      bucket = "te-terraform-up-and-running-state"
      key = "global/billingAlarm/terraform.tfstate"
      region = "us-east-2"

      dynamodb_table = "terraform_up_and_running_locks"
      encrypt = true
  }
}