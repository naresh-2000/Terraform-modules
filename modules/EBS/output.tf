###################################################################
###################    Output: EBS volume id    ###################
###################################################################

output "root_volume_id" {
  value = aws_ebs_volume.root_volume.id
}

output "mount_volume_id" {
  value = aws_ebs_volume.mount_volume.id
}
