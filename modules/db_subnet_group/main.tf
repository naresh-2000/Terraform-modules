# Module to create subnet group, parameter group, security group, RDS postgres server. 

###################################################################
################  Create Subnet group  ############################
###################################################################

resource "aws_db_subnet_group" "this" {
  name        = var.name
  description = var.description
  subnet_ids  = var.subnet_ids
}
