# Module to create lambda layers. 

###################################################################
###################  Create lambda layers  ########################
###################################################################

resource "aws_lambda_layer_version" "lambda_layer" {
  filename      = var.layer_zip_file
  layer_name    = var.layer_name
  description   = var.layer_description
  compatible_runtimes = var.compatible_runtimes
}