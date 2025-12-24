resource "aws_security_group" "pwd_eazylabs_alb_sg" {
  vpc_id      = data.aws_vpc.pwd_eazylabs.id
  name        = "EAZYLabs-ALB-SG"
  description = "EAZYLabs ALB SG to allow http/https connection"
  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "pwd_eazylabs_ec2_sg" {
  vpc_id      = data.aws_vpc.pwd_eazylabs.id
  name        = "EAZYLabs-EC2-SG"
  description = "EAZYLabs SG EC2 to allow ssh/http/https connection"
  
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    security_groups = [ aws_security_group.pwd_eazylabs_alb_sg.id ]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    security_groups = [ aws_security_group.pwd_eazylabs_alb_sg.id ]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}




