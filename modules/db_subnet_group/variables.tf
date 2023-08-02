###################################################################
########   Variables required for subet group    ##################
###################################################################

variable "name" {
  type        = string
  description = "Name of the subnet group"
}

variable "description" {
  type        = string
  description = "Description of the subnet group"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the subnet group"
}
