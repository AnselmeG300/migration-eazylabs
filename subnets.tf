data "aws_subnet" "public_subnet" {
  tags = {
    Name = "EAZYTraining VPC infrastructure-public-a"
  }
}

data "aws_subnet" "public_subnet1" {
  tags = {
    Name = "EAZYTraining VPC infrastructure-public-b"
  }
}