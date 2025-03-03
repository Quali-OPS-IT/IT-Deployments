resource "aws_instance" "terraform_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Ubuntu 22.04
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public.id
  security_groups = [aws_security_group.allow_ssh_http.name]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  key_name = "your-key-pair"  # Replace with your actual AWS Key Pair

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

  tags = { Name = "Terraform-Learning-Instance" }
}

output "instance_public_ip" {
  value = aws_instance.terraform_instance.public_ip
}
