###################################################################
#################    Output: Subnet group id    ###################
###################################################################

output "subnet_group_id" {
  description = "The ID of the created subnet group"
  value       = aws_db_subnet_group.this.id
}
