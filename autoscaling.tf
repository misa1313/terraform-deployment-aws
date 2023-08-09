resource "aws_autoscaling_group" "autoscaling_group-2" {
  launch_configuration = aws_launch_configuration.launch_config-2.name
  min_size             = 1
  max_size             = 1
  desired_capacity     = 1
  vpc_zone_identifier  = [aws_subnet.subnet-2-2.id]
  target_group_arns    = [aws_lb_target_group.target_group-2.arn]
}

resource "aws_autoscaling_policy" "scale_out_policy-2" {
  name                   = "scale-out-policy"
  #scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "TargetTrackingScaling"
  #cooldown               = 300 
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group-2.name

  target_tracking_configuration {
    target_value           = 80.0
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"   
    }
  }
}
