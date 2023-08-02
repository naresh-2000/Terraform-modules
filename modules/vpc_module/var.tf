###################################################################
######## Variables required for complete VPC setup  ###############
###################################################################

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks for private subnets"
}