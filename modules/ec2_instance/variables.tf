###################################################################
########   Variables required for EC2 instance  ###################
###################################################################

variable "region" {
  type        = string
  description = "AWS region"
}

variable "ami" {
  type        = string
  description = "ID of the AMI to use for the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type for the EC2 instance"
}

variable "key_name" {
  type        = string
  description = "Name of the key pair to associate with the EC2 instance"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet where the EC2 instance will be launched"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs for the EC2 instance"
}

variable "name" {
  type        = string
  description = "Name for the EC2 instance"
}

variable "availability_zone" {
  description = "The availability zone in which the EC2 instance will be created."
  type        = string
}

variable "root_volume_id" {
  description = "The ID of the root EBS volume."
  type        = string
}

variable "mount_volume_id" {
  description = "The ID of the mount EBS volume."
  type        = string
}