resource "aws_instance" "ivolve_lab" {

  ami           = "ami-00beae93a2d981137"  # Update to your preferred AMI
  instance_type = var.ec2_instance_type
  subnet_id     = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.ec2_sg.name]

  tags = {
    Name = "lab Server"
  }
}
resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.ivolve.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
