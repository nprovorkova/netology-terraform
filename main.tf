# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

terraform {
  backend "s3" {
    bucket = "netology-state-dev"
    key    = "bucket-key-path"
    region = "eu-north-1"
  }
}

data "aws_ami" "ubuntu" {
    most_recent = true

     filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

resource "aws_instance" "aws_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  count         = 1

  lifecycle {
    create_before_destroy = true
  }
}