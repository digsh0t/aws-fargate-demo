resource "aws_security_group" "rds_sg" {
  name   = "rds_sg"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 5432
    to_port     = 5432
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

resource "aws_db_subnet_group" "default" {
  name       = "demo_db_subnet_group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "Demo DB subnet group"
  }
}

resource "aws_db_instance" "fargate-demo-db" {
  engine                 = "postgres"
  identifier             = var.db_name
  allocated_storage      = 5
  instance_class         = "db.t4g.micro"
  username               = var.db_username
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
  publicly_accessible    = true
  db_subnet_group_name   = aws_db_subnet_group.default.name
}
