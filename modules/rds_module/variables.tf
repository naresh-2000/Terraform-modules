###################################################################
################ Variables used to create RDS #####################
###################################################################

variable "region" {
  type        = string
  description = "AWS region"
}

variable "db_instance_identifier" {
  type        = string
  description = "Identifier for the RDS instance"
}

variable "allocated_storage" {
  type        = number
  description = "Allocated storage for the RDS instance"
}

variable "engine" {
  type        = string
  description = "Engine for the RDS instance (e.g., postgres)"
}

variable "engine_version" {
  type        = string
  description = "Version of the PostgreSQL engine"
}

variable "instance_class" {
  type        = string
  description = "Instance class for the RDS instance"
}

variable "name" {
  type        = string
  description = "Name for the RDS instance"
}

variable "username" {
  type        = string
  description = "Username for the RDS instance"
}

variable "password" {
  type        = string
  description = "Password for the RDS instance"
}

variable "parameter_group_name" {
  type        = string
  description = "Name of the custom parameter group for the RDS instance"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs for the RDS instance"
}

variable "subnet_group_name" {
  type        = string
  description = "Name of the subnet group for the RDS instance"
}
