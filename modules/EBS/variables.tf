###################################################################
###########   Variables required for EBS Volumes    ###############
###################################################################
variable "availability_zone" {
  description = "The availability zone in which the EBS volumes will be created."
  type        = string
}

variable "root_volume_size" {
  description = "The size of the root EBS volume in GB."
  type        = number
}

variable "mount_volume_size" {
  description = "The size of the mount EBS volume in GB."
  type        = number
}