resource "aws_autoscaling_group" "app_pwd_eazylabs_asg" {
  name                = local.asg_name
  desired_capacity    = 1
  min_size            = 1
  max_size            = 3
  vpc_zone_identifier = [data.aws_subnet.public_subnet.id, data.aws_subnet.public_subnet1.id] # Remplacez avec votre liste de sous-réseaux

  launch_template {
    id      = aws_launch_template.pwd_eazylabs_lt.id
    version = "$Latest"
  }

  target_group_arns         = [aws_lb_target_group.pwd_eazylabs_lb_tg.arn]
  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = true

  tag {
    key                 = "Name"
    value               = local.instance_name
    propagate_at_launch = true
  }
}