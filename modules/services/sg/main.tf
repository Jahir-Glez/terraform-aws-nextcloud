# ALB Security Group
resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Security Group for ALB"
  vpc_id      = var.vpc_id
  tags        = var.tags

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic from anywhere"
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS traffic from anywhere"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}

# ECS Security Group
resource "aws_security_group" "ecs_sg" {
  name        = "ecs_sg"
  description = "Security Group for ECS"
  vpc_id      = var.vpc_id
  tags        = var.tags

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    description     = "Allow HTTP traffic from ALB"
    security_groups = [aws_security_group.alb_sg.id]
  }
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    description     = "Allow HTTPS traffic from EFS"
    security_groups = [aws_security_group.efs_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound traffic to RDS"
  }
}

# RDS Security Group
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Security Group for RDS"
  vpc_id      = var.vpc_id
  tags        = var.tags

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    description     = "Allow MySQL traffic from ECS"
    security_groups = [aws_security_group.ecs_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "Allow all outbound traffic"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EFS Security Group
resource "aws_security_group" "efs_sg" {
  name        = "efs_sg"
  description = "Security Group for EFS"
  vpc_id      = var.vpc_id
  tags        = var.tags

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow NFS traffic from ECS"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}

# VPC Endpoints SG
resource "aws_security_group" "vpc_endpoints_sg" {
  name        = "vpc_endpoints_sg"
  description = "Security Group for VPC Endpoint"
  vpc_id      = var.vpc_id
  tags        = var.tags

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    description     = "Allow HTTPS traffic from ECS"
    security_groups = [aws_security_group.ecs_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}
