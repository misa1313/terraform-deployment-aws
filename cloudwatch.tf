resource "aws_cloudwatch_event_rule" "state_change_rule-2" {
  name = "ASGStateChangeRule"

  event_pattern = jsonencode({
    source = ["aws.autoscaling"],
    detail_type = ["AWS API Call via CloudTrail"],
    detail = {
      eventSource = ["autoscaling.amazonaws.com"],
      eventName = ["UpdateAutoScalingGroup"]
    }
  })
}

resource "aws_cloudwatch_event_target" "state_change_target-2" {
  rule = aws_cloudwatch_event_rule.state_change_rule-2.name
  arn  = aws_sns_topic.sns_updates-2.arn
}

resource "aws_cloudwatch_metric_alarm" "state_change_alarm-2" {
  alarm_name          = "ASGStateChangeAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name        = "GroupDesiredCapacity"
  namespace          = "AWS/AutoScaling"
  period             = "60"
  statistic          = "Average"
  threshold          = "1"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaling_group-2.name
  }

  alarm_description = "Checking ASG state changes."
  alarm_actions     = [aws_sns_topic.sns_updates-2.arn]
}
