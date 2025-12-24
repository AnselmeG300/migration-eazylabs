data "aws_acm_certificate" "certficate_ssl1" {
  domain = "*.labs.eazytraining.fr"
}

data "aws_acm_certificate" "certficate_ssl2" {
  domain = "*.direct.docker.labs.eazytraining.fr"
}