provider "aws" {
  region     = local.aws_region
  access_key = "AKIAURSEAK2Z7JPAPR5N"
  secret_key = "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"
}

data "aws_caller_identity" "current" {}