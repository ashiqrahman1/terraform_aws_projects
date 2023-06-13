resource "aws_db_instance" "rds" {
  allocated_storage = var.db_size
  identifier = var.rds_name
  db_name = var.db_name
  engine = "mysql"
  engine_version = "8.0.32"
  instance_class = var.db_instance
  username = var.db_user
  password = var.db_pass
  multi_az = false
  db_subnet_group_name = aws_db_subnet_group.rds_subnet.name
  vpc_security_group_ids = [ aws_security_group.db_sg.id ]
  skip_final_snapshot = true
}


resource "aws_db_subnet_group" "rds_subnet" {
    name = "subnet_group"
    subnet_ids = [aws_subnet.db1.id,aws_subnet.db2.id]

    tags = {
      Name = "db-subnet"
    }
}