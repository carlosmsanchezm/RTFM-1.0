terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

variable "instances" {
  default = {
    "nodejs" = "t2.micro"
    "nginx"  = "t2.micro"
  }
}

data "aws_ami" "example" {
  most_recent      = true
  owners           = ["amazon"]  # 'amazon' for Amazon-owned AMIs

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]  # Filter for Amazon Linux 2 AMIs
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


# EC2 Instance
resource "aws_instance" "example" {
    for_each = var.instances
    ami           = data.aws_ami.example.id
    instance_type = each.value
    key_name     = "${each.key}-key"
    tags = {
        Name = "Instance-${each.key}"
    }
}

# VPC
resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "example-vpc"
  }
}

# Subnet
resource "aws_subnet" "example_subnet" {
  vpc_id            = aws_vpc.example_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "example-subnet"
  }
}

# Security Group
resource "aws_security_group" "example_sg" {
  name        = "example-security-group"
  description = "Example Security Group"
  vpc_id      = aws_vpc.example_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "example-sg"
  }
}

# CloudWatch Alarms for EC2 instance monitoring
resource "aws_cloudwatch_metric_alarm" "example_alarm" {
  for_each = aws_instance.example
  alarm_name                = "example-alarm-${each.key}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 60
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors EC2 CPU utilization for ${each.key}"
  alarm_actions             = []
  insufficient_data_actions = []

  dimensions = {
    InstanceId = each.value.id
  }
}

resource "local_file" "ansible_inventory" {
  content = jsonencode({
    myhosts = {
      hosts = { for ip in aws_instance.example : ip.public_ip => {} }
    }
  })
  filename = "${path.module}/inventory.json"
}




