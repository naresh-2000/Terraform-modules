###################################################################
#############   Variables required for lambda layers ##############
###################################################################

variable "region" {
  description = "AWS region where the Lambda layer will be created."
}

variable "layer_name" {
  description = "Name of the Lambda layer."
  type        = string
}

variable "layer_description" {
  description = "Description of the Lambda layer."
  type        = string
}

variable "compatible_runtimes" {
  description = "List of compatible Lambda function runtimes with the layer."
  type        = list(string)
}

variable "layer_zip_file" {
  description = "Path to the ZIP file containing the Lambda layer code."
}