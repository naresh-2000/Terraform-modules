# Module to create security group. 

###################################################################
##############  Create an Elastic IP   ############################
###################################################################

resource "aws_eip" "elastic_ip" {
  vpc                       = true
  instance                  = var.instance_id
  associate_with_private_ip  = var.associate_with_private_ip
}