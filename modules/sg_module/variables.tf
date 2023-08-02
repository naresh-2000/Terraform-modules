###################################################################
########   Variables required for security group    ###############
###################################################################

variable "security_group_name" {
  type        = string
  description = "Name of the security group"
}
variable "vpc_id" {
  type        = string
  description = "VPC for security group"
}

variable "inbound_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "List of inbound rules for the security group"
}
