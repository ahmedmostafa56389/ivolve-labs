resource "aws_db_instance" "db" {
  count = 2

  identifier             = "db-ahmed[count.index].key"
  engine                 = "mysql"
  engine_version         = var.db_engine_version
  instance_class         = var.rds_instance_type
  allocated_storage      = 10
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  skip_final_snapshot = true

  # Set the subnet ID based on the current element in the private_subnets list
  # subnet_id = var.private_subnets[count.index].value

}

resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = var.private_subnets[count.index].id

  tags = {
    Name = "Main DB Subnet Group"
  }
}

resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.ivolve.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
