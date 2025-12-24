data "aws_ami" "pwd_eazylabs_ami" {
  most_recent = true
  owners      = [data.aws_caller_identity.current.account_id]
  filter {
    name   = "name"
    values = ["eazy-labs-*"]
  }
}