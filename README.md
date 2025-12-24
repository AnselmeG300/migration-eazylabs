# Migration of EazyLabs Infrastructure to AWS (Ireland Region)

EazyLabs is an EazyTraining platform that allows learners to perform hands-on labs for their courses. This guide walks you through migrating the EazyLabs infrastructure to AWS's `eu-west-1` (Ireland) region.

---

## Migration Objective

The goal of this migration is to move the existing EazyLabs infrastructure to AWS's Ireland region by creating a custom AMI image, generating SSL certificates for security, and configuring the necessary DNS records to ensure seamless access to the application.

---

## Prerequisites

Before starting, ensure that you:

- Have an active AWS account configured in the `eu-west-1` (Ireland) region.
- Own a domain and have the ability to modify its DNS records.
- Have access to the **AWS Console**, **EC2 services**, **Certificate Manager (ACM)**, and **Route 53**.
- Have an environment ready for building the AMI and making the necessary modifications.

---

## Infrastructure Overview

This project deploys a complete AWS infrastructure using Terraform, consisting of the following components:

### Network Infrastructure
- **VPC**: Custom Virtual Private Cloud with DNS support
- **Subnets**: Public and private subnets across multiple availability zones
- **Security Groups**: Configured to allow HTTP/HTTPS traffic to the ALB and SSH access to EC2 instances

### Compute Resources
- **Launch Template**: Defines EC2 instance configuration with custom AMI
- **Auto Scaling Group (ASG)**: Automatically manages EC2 instance scaling based on demand
- **AMI**: Custom Amazon Machine Image with pre-configured EazyLabs environment

### Load Balancing
- **Application Load Balancer (ALB)**: Distributes incoming traffic across EC2 instances
- **Target Groups**: Routes traffic to healthy instances
- **Listeners**: HTTP (port 80) and HTTPS (port 443) listeners with SSL certificates

### Security & Certificates
- **SSL Certificates**: Configured for `*.labs.your_domain` and `*.direct.docker.labs.your_domain`
- **IAM Roles**: Permissions for EC2 instances to interact with AWS services
- **Key Pairs**: SSH key pairs for secure instance access

### Monitoring & Automation
- **CloudWatch**: Monitoring and logging for infrastructure health
- **EventBridge**: Scheduled rules for automated tasks
- **Lambda Functions**: Serverless functions for infrastructure automation

### Terraform Configuration Files
- **provider.tf**: AWS provider configuration for eu-west-1 region
- **vpc.tf**: VPC and networking setup
- **subnets.tf**: Subnet configuration
- **sg.tf**: Security group rules
- **alb.tf**: Application Load Balancer configuration
- **asg.tf**: Auto Scaling Group settings
- **launch_template.tf**: EC2 launch template
- **certificats.tf**: SSL certificate configuration
- **lambda.tf**: Lambda function definitions
- **cloudwatch.tf**: CloudWatch alarms and metrics
- **event_bridge.tf**: EventBridge rules and targets
- **role.tf**: IAM roles and policies
- **locals.tf**: Local variables
- **terraform.tfvars**: Variable values (customize for your environment)

---

## Migration Steps

### 1. Create an AMI with Your Domain Name

To begin, you need to create a custom AMI image of your infrastructure with your domain name.

#### a) Modify the `config.go` File

Change the domain value in the `DomainName` constant to reflect your domain name.

Example modification in `config.go`:

```go
// Example modification in config.go
flag.StringVar(&PlaygroundDomain, "playground-domain", "docker.labs.eazytraining.fr", "Domain to use for the playground")
```

#### b) Generate the AMI

Once the modification is done, you can generate the AMI from your machine or EC2 instance using the standard procedure in the AWS Console or via the AWS CLI.

#### c) Assign the Generated AMI ID

After creating the AMI, assign the AMI ID to the `ami` variable in your Terraform configuration or infrastructure.

```hcl
variable "ami" {
  description = "ID of the AMI generated with your domain name"
  default     = "ami-xxxxxxxxxxxxxxxxx"  # Replace with your AMI ID
}
```

---

### 2. Generate SSL Certificates for Subdomains

To secure your subdomains with SSL, you need to generate certificates for the following subdomains:

- `*.labs.your_domain`
- `*.direct.docker.labs.your_domain`

#### a) Create an SSL Certificate in AWS Certificate Manager (ACM)

1. Go to **AWS Certificate Manager (ACM)** in the AWS Console.
2. Click on **Request a certificate**.
3. Select **Public Certificate** and add the subdomains `*.labs.your_domain` and `*.direct.docker.labs.your_domain`.
4. Validate domain ownership via DNS.
5. Once the certificate is validated and issued, note down the **ARNs** of the certificates.

#### b) Assign the Certificate ARNs

Add the obtained certificate ARNs to the variables in your infrastructure:

```hcl
variable "certificate_ssl" {
  description = "ARN of the SSL certificate for *.labs.your_domain"
  default     = "<CERTIFICATE_LABS_ARN>"  # Replace with the actual ARN
}

variable "certificate_ssl2" {
  description = "ARN of the SSL certificate for *.direct.docker.labs.your_domain"
  default     = "<CERTIFICATE_DIRECT_DOCKER_ARN>"  # Replace with the actual ARN
}
```

---

### 3. Configure DNS Records

Next, configure DNS records to point to the Elastic Load Balancer (ALB) of your infrastructure.

#### a) CNAME Record for `docker.labs.your_domain`

Go to **Route 53** and create a **CNAME** record for the subdomain `docker.labs.your_domain`. This should point to the DNS of your ALB.

Example CNAME record:

| Name                        | Type   | ALB DNS Value                                  |
|-----------------------------|--------|-----------------------------------------------|
| docker.labs.your_domain     | CNAME  | `dns_of_alb-xyz.us-west-1.elb.amazonaws.com`  |

#### b) Other CNAME Records

Create the following CNAME records to route other subdomains:

- `*.docker.labs.your_domain` to `docker.labs.your_domain`
- `*.direct.docker.labs.your_domain` to `docker.labs.your_domain`

This ensures that all subdomains of `docker.labs.your_domain` are correctly redirected to the ALB, simplifying traffic management.

---

## Post-Migration Checks

After the migration, it is important to verify that the infrastructure works as expected.

1. **SSL Certificate Verification**: Test access to `*.labs.your_domain` and `*.direct.docker.labs.your_domain` to ensure the SSL certificates are valid.
2. **DNS Record Verification**: Use tools like `nslookup` or `dig` to verify that the DNS records correctly point to the ALB.
3. **Application Testing**: Verify that all features of the EazyLabs application are operational after the migration.

---

## Useful Resources

- **AWS Certificate Manager (ACM)**: [ACM Documentation](https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html)
- **Route 53 - DNS Management**: [Route 53 Documentation](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/Welcome.html)
- **Elastic Load Balancer (ALB)**: [ALB Documentation](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)

--- 

