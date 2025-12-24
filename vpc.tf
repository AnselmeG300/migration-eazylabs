data "aws_vpc" "pwd_eazylabs" {
  tags = {
    Name = "EAZYTraining VPC infrastructure"
  }
}

