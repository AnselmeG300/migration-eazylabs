data "aws_key_pair" "name" {
  tags = {
    Name = "eazylabs-key"
  }
}