# Module to create security group. 

###################################################################
#################  Create EBS volume   ############################
###################################################################

resource "aws_ebs_volume" "root_volume" {
  availability_zone = var.availability_zone
  size              = var.root_volume_size
}

resource "aws_ebs_volume" "mount_volume" {
  availability_zone = var.availability_zone
  size              = var.mount_volume_size
}