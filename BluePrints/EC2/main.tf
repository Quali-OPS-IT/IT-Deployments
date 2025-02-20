resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = merge(
    var.common_tags,  # Use common_tags variable directly
    var.tags,         # Use tags variable directly
    {                 # Manual tags
      Name        = "Torque-EC2"
      Environment = "Dev"
    }
    )
  }