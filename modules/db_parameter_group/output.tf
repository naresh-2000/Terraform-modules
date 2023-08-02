###################################################################
#################    Output: parameter group id   #################
###################################################################

output "parameter_group_id" {
  description = "The ID of the created parameter group"
  value       = aws_db_parameter_group.this.id
}
