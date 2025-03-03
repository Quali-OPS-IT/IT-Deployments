provider "aws" {
  region = "eu-west-1"  # Change this to your desired region
}

# Create a security group to allow SSH and HTTP access
resource "aws_security_group" "terraform_sg" {
  name_prefix = "terraform-sg-"
  description = "Allow SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (CHANGE THIS for security)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define an EC2 instance to host the learning environment
resource "aws_instance" "terraform_instance" {
  ami           = "ami-0a9c85f551385c96d"  # Ubuntu 22.04 LTS amd64
  instance_type = "t3.micro"  # Free-tier eligible
  key_name      = "your-key-pair"  # Replace with your existing AWS key pair name
  security_groups = [aws_security_group.terraform_sg.name]

  user_data = <<-EOF
    #!/bin/bash
    apt update -y
    apt install -y unzip git curl

    # Install Terraform
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    apt update && apt install -y terraform

    # Clone the Terraform-The-Hard-Way repo
    git clone https://github.com/AdminTurnedDevOps/Terraform-The-Hard-Way.git /home/ubuntu/terraform-the-hard-way
    chown -R ubuntu:ubuntu /home/ubuntu/terraform-the-hard-way
  EOF

  tags = {
    Name = "Terraform-Learning-Instance"
  }
}

# Output the public IP for SSH access
output "instance_public_ip" {
  value = aws_instance.terraform_instance.public_ip
}
