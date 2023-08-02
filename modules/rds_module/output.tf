###################################################################
##################  Output : RDS endpoints ########################
###################################################################

output "endpoint" {
  description = "The endpoint of the created RDS instance"
  value       = aws_db_instance.rds_postgresql.endpoint
}

output "db_instance_identifier" {
  description = "The ID of the created RDS instance"
  value       = aws_db_instance.rds_postgresql.id
}
