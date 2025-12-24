resource "aws_launch_template" "pwd_eazylabs_lt" {
  name_prefix            = "pwd_eazylabs-"
  image_id               = data.aws_ami.pwd_eazylabs_ami.id
  instance_type          = local.instance_type
  key_name               = data.aws_key_pair.name.key_name
  vpc_security_group_ids = [aws_security_group.pwd_eazylabs_ec2_sg.id]

  lifecycle {
    create_before_destroy = true
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.eazylabs_ec2_instance_profile.name
  }


  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_type           = "gp2"
      volume_size           = 100
      encrypted             = true
      delete_on_termination = true
    }
  }

}

resource "aws_iam_instance_profile" "eazylabs_ec2_instance_profile" {
  name = "eazylabs-ec2-instance-profile-for-autoscaling"
  role = aws_iam_role.eazylabs_ec2_role.name
}
