###################################################################
########### Outputs- VPC, subnets and gateway IDs   ############### 
###################################################################

output "vpc_id" {
  description = "ID of the created VPC"
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the created public subnets"
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the created private subnets"
  value = aws_subnet.private[*].id
}

output "internet_gateway_id" {
  description = "ID of the created Internet Gateway"
  value = aws_internet_gateway.gw.id
}

output "nat_gateway_ids" {
  description = "IDs of the created NAT Gateways"
  value = aws_nat_gateway.nat[*].id
}