# Module to create custom parameter group. 

###################################################################
##############  Create DB parameter group  ########################
###################################################################

resource "aws_db_parameter_group" "this" {
  name        = var.name
  family      = var.family
  description = var.description

  parameter {
    name  = "autovacuum_vacuum_scale_factor"
    value = "0.1"
  }

  parameter {
    name  = "autovacuum_analyze_scale_factor"
    value = "0.05"
  }

  # Add more custom parameters as needed
}
