# Module to create RDS postgres server. 

###################################################################
#####################    CREATE RDS    ############################
###################################################################

resource "aws_db_instance" "rds_postgresql" {
  identifier             = var.db_instance_identifier
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  name                   = var.name
  username               = var.username
  password               = var.password
  parameter_group_name   = var.parameter_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_group_name      = var.subnet_group_name
}
