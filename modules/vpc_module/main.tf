# Module to create VPC, private subnet, public subnet, Internet gateway, route table, subnets association. 

###################################################################
##############     Create VPC         #############################
###################################################################

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags       = {
    Name = var.vpc_name
  }
}


###################################################################
######## Create Internet and NAT gateway, Route tables ############
###################################################################

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# resource "aws_nat_gateway" "nat" {
#   count         = length(var.public_subnet_cidrs)
#   subnet_id     = element(aws_subnet.public.*.id, count.index)
#   allocation_id = aws_eip.nat[count.index].id
# }

# resource "aws_eip" "nat" {
#   count = length(var.public_subnet_cidrs)
# }

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

# resource "aws_route_table" "private" {
#   count = length(var.public_subnet_cidrs)
#   vpc_id = aws_vpc.main.id

#   route {
#    cidr_block = "0.0.0.0/0"
#    gateway_id = aws_nat_gateway.nat[count.index].id
#   }
# }


###################################################################
###########  Create Public and Private subnets      ############### 
###################################################################

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = "us-east-1a" # Replace with your desired AZ

  tags = {
    Name = "${var.vpc_name}-public-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = "us-east-1b" # Replace with your desired AZ

  tags = {
    Name = "${var.vpc_name}-private-${count.index + 1}"
  }
}

###################################################################
#############    Route table association         ################## 
###################################################################

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}