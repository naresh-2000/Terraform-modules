###################################################################
########   Variables required for elastic IP   ####################
###################################################################

variable "region" {
  description = "The AWS region in which the Elastic IP will be allocated."
  type        = string
}

variable "instance_id" {
  description = "The ID of the EC2 instance to associate the Elastic IP with."
  type        = string
}

variable "associate_with_private_ip" {
  description = "If true, the Elastic IP will be associated with the private IP address of the EC2 instance."
  type        = bool
  default     = false
}