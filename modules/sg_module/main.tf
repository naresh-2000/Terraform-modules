# Module to create security group. 

###################################################################
##############  Create Security group  ############################
###################################################################

resource "aws_security_group" "sg" {
  name_prefix = var.security_group_name
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "inbound" {
  count = length(var.inbound_rules)

  type        = "ingress"
  from_port   = var.inbound_rules[count.index].from_port
  to_port     = var.inbound_rules[count.index].to_port
  protocol    = var.inbound_rules[count.index].protocol
  cidr_blocks = var.inbound_rules[count.index].cidr_blocks

  security_group_id = aws_security_group.sg.id
}