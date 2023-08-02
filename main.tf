###################################################################
##############   Invoke the cloud provider      ################### 
###################################################################

provider "aws" {
  region = "us-east-1" # Change this to your desired region
}

###################################################################
#####################   CREATE VPC    ############################# 
###################################################################

module "grid_vpc" {
  source = "./modules/vpc_module"
  vpc_name             = "Tentree-VPC"
  vpc_cidr_block       = "172.0.0.0/16"
  public_subnet_cidrs  = ["172.0.1.0/24", "172.0.2.0/24"]
  private_subnet_cidrs = ["172.0.3.0/24", "172.0.4.0/24"]
}

###################################################################
####################  CREATE IAM USERS  ########################### 
###################################################################

module "grid_iam_users" {
  source = "./modules/iam_module"

  users = [
    {
      username         = "NodeWebAPI"
      managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    },
    {
      username         = "S3-fullaccess"
      managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]
    }
  ]
}

###################################################################
###################  CREATE RDS - POSTGRESQL ###################### 
###################################################################

# create security group
module "staging-db-sg" {
  source = "./modules/sg_module"

  security_group_name = "rds-staging-sg"
  vpc_id = module.grid_vpc.vpc_id
  inbound_rules = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

# create custom parameter group
module "staging_parameter_group" {
  source = "./modules/db_parameter_group"

  name        = "staging-pg"
  family      = "postgres13"  # Update with your desired PostgreSQL version
  description = "Custom parameter group for RDS staging PostgreSQL"
}

# create private subnet group
module "staging_subnet_group" {
  source = "./modules/db_subnet_group"

  name        = "staging-subnet-group"
  description = "Custom subnet group for RDS staging PostgreSQL"
  subnet_ids  = module.grid_vpc.private_subnet_ids 
}

# Create the primary RDS PostgreSQL instance
module "staging_rds" {
  source = "./modules/rds_module"  

  db_instance_identifier = "rds-staging-db"
  allocated_storage      = 100
  engine                 = "postgres"
  engine_version         = "13"
  instance_class         = "db.t3.small"
  name                   = "rds-staging-db"
  username               = "postgres"
  password               = random_password.password.result
  parameter_group_name   = module.staging_parameter_group.parameter_group_id
  vpc_security_group_ids = module.staging_db_sg.security_group_id
  subnet_group_name      = module.staging_subnet_group.subnet_group_id
}

# Create a read replica for the primary RDS instance
module "staging_read_replica" {
  source = "./rds_module"  # Replace with the path to your RDS module

  db_instance_identifier = var.read_replica_db_instance_identifier
  engine                 = "postgres"
  engine_version         = "13"
  instance_class         = "db.t3.small"
  name                   = "rds-staging-readreplica"
  parameter_group_name   = module.staging_parameter_group.parameter_group_id
  vpc_security_group_ids = module.staging_db_sg.security_group_id
  subnet_group_name      = module.staging_subnet_group.subnet_group_id
  source_db_instance_identifier = module.staging_rds.db_instance_identifier
}

# Generate a random password for the RDS instance
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}


###################################################################
###############   CREATE EC2 INSTANCE   ###########################
###################################################################

# create security group
module "instance-sg" {
  source = "./modules/sg_module"

  security_group_name = "instance-sg"
  vpc_id = module.grid_vpc.vpc_id
  inbound_rules = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

# create key pair 
module "instance-key-pair" {
  source = "./modules/key_pair"

  key_name = "instance-key"
}

# Create EBS volumes
module "ebs_volumes" {
  source = "./modules/EBS"

  region             = "us-east-1"
  availability_zone  = "us-east-1a"
  root_volume_size   = 50
  mount_volume_size  = 100
}

# Create ec2 instance 
module "ec2_instance" {
  source = "./modules/ec2_instance"

  region             = "us-east-1"
  ami_id             = "ami-0c55b159cbfafe1f0" // Replace with your desired AMI ID
  instance_type      = "t3.small"
  availability_zone  = "us-east-1a"
  root_volume_id     = module.ebs_volumes.root_volume_id
  mount_volume_id    = module.ebs_volumes.mount_volume_id
  instance_name      = "test-instance"
  key_name             = module.instance-key-pair.key_name
  subnet_id            = module.grid_vpc.public_subnet_ids[0]
  vpc_security_group_ids = [module.instance-sg.security_group_id]
}

# create EIP and associate it to EC2 
module "elastic_ip" {
  source = "./modules/EIP"

  region                   = "us-east-1"
  instance_id              = module.ec2_instance.instance_id
  associate_with_private_ip = true
}

###################################################################
##################   CREATE S3 BUCKET   ###########################
###################################################################

# Create s3 bucket 
module "s3_bucket" {
  source = "./modules/s3"

  bucket_name  = "test-bucket"
  region       = "us-east-1"
  tags         = { "Environment" = "test", "Project" = "MyProject" }
  iam_user_name = "grid-user" # can try with ARN - 
}