resource "aws_vpc" "tf_learning_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "Terraform-Learning-VPC" }
}

resource "aws_subnet" "tf_learning_subnet" {
  vpc_id                  = sg-07a054516ce47dd8f
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-1a"
  tags = { Name = "Terraform-Learning-Subnet" }
}

resource "aws_internet_gateway" "tf_learning_gw" {
  vpc_id = sg-07a054516ce47dd8f
  tags = { Name = "Terraform-Learning-GW" }
}

resource "aws_route_table" "tf_learning_rt" {
  vpc_id = sg-07a054516ce47dd8f
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_learning_gw.id
  }
  tags = { Name = "Terraform-Learning-RT" }
}

resource "aws_route_table_association" "tf_learning_rta" {
  subnet_id      = aws_subnet.tf_learning_subnet.id
  route_table_id = aws_route_table.tf_learning_rt.id
}

resource "aws_security_group" "tf_learning_sg" {
  id = "sg-07a054516ce47dd8f"
  vpc_id = sg-07a054516ce47dd8f
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "Terraform-Learning-SG" }
}
