###################################################################
########   Variables required for parameter group   ###############
###################################################################

variable "name" {
  type        = string
  description = "Name of the parameter group"
}

variable "family" {
  type        = string
  description = "Family of the parameter group (e.g., postgres12)"
}

variable "description" {
  type        = string
  description = "Description of the parameter group"
}
