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

resource "aws_key_pair" "common_key" {
  key_name   = "common-key"
  public_key = file("~/.ssh/id_rsa.pub")  # Path to your public key file
}


# EC2 Instance
resource "aws_instance" "example" {
    for_each = var.instances
    ami           = data.aws_ami.example.id
    instance_type = each.value
    key_name     = aws_key_pair.common_key.key_name

    # Attached security group
    vpc_security_group_ids = [aws_security_group.example_sg.id]
    
    tags = {
        Name = "Instance-${each.key}"
        Type = each.key  # 'nodejs' or 'nginx'
    }
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "example_sg" {
  name        = "example-security-group"
  description = "Example Security Group"
  vpc_id      = data.aws_vpc.default.id

  # SSH Access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP Access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS Access
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Node.js Application Access on Port 3000
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rules
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
    content = templatefile("${path.module}/inventory.tmpl", {
        nodejs_public_ips  = [for name, instance in aws_instance.example : instance.public_ip if instance.tags["Type"] == "nodejs"],
        nodejs_private_ips = [for name, instance in aws_instance.example : instance.private_ip if instance.tags["Type"] == "nodejs"],
        nginx_ips          = [for name, instance in aws_instance.example : instance.public_ip if instance.tags["Type"] == "nginx"]
    })
    filename = "${path.module}/inventory.ini"
}