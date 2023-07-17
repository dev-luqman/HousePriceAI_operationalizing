# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

data "aws_availability_zones" "available" {}
data "aws_secretsmanager_secret_version" "rds_secret" {
  secret_id = ml_housing_db_secret
}

locals {
  db_secret = jsondecode(data.aws_secretsmanager_secret_version.rds_secret.secret_string)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name                 = "house_price"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_db_subnet_group" "house_price" {
  name       = "house_price"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "house_price"
  }
}

resource "aws_security_group" "rds" {
  name   = "house_price_rds"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "house_price_rds"
  }
}

resource "aws_db_parameter_group" "house_price" {
  name   = "houseprice"
  family = "postgres14"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "house_price" {
  identifier        = "houseprice"
  instance_class    = "db.t3.micro"
  allocated_storage = 5
  engine            = "postgres"
  engine_version    = "14.3"
  # username               = "house_price"
  # password               = var.db_password
  username               = local.db_secret.username
  password               = local.db_secret.password
  db_subnet_group_name   = aws_db_subnet_group.house_price.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.house_price.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}
