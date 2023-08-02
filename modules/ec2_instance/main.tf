# Module to create EC2 instance. 

###################################################################
##############   Create EC2 instance   ############################
###################################################################

resource "aws_instance" "ec2_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  availability_zone = var.availability_zone

  // Attach the root volume
  root_block_device {
    volume_id = var.root_volume_id
  }

  // Attach the mount volume
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_id   = var.mount_volume_id
  }

  tags = {
    Name = var.name
  }

  user_data = file("${path.module}/user_data.sh")
}