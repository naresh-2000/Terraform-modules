# Module to create .pem key-pair for EC2

###################################################################
##############     Create key pair     ############################
###################################################################

resource "aws_key_pair" "this" {
  key_name = var.key_name
}

# Save the private key to a file using a local-exec provisioner
resource "null_resource" "save_private_key" {
  triggers = {
    key_name = aws_key_pair.this.key_name
  }

  provisioner "local-exec" {
    command = "echo '${aws_key_pair.this.private_key}' > ${path.module}/${var.key_name}.pem"
  }
}

