### Security Group for ALB
resource "aws_security_group" "alb_sg"{
    name = "alb_sg"
    description = "Security Group for ALB"
    vpc_id = aws_vpc.nextcloud_vpc.id
    tags = var.tags

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTP traffic from anywhere"

    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTPS traffic from anywhere"
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound traffic"
    }
}

### Security Group for RDS
resource "aws_security_group" "rds_sg"{
    name = "rds_sg"
    description = "Security Group for RDS"
    vpc_id = aws_vpc.nextcloud_vpc.id
    tags = var.tags

    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        description = "Allow HTTP traffic from ECS"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        description = "Allow outbound traffic to ECS"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


### Security Group for ECS Instances
resource "aws_security_group" "ecs_sg"{
    name = "ecs_sg"
    description = "Security Group for SCS"
    vpc_id = aws_vpc.nextcloud_vpc.id
    tags = var.tags

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        description = "Allow HTTP traffic from ALB"
        security_groups = [aws_security_group.alb_sg.id]
    }
    egress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        description = "Allow outbound traffic to RDS"
        security_groups = [aws_security_group.rds_sg.id]
    }
}

### Security Group for VPC Endpoints
resource "aws_security_group" "vpc_endpoints_sg"{
    name = "vpc_endpoints_sg"
    description = "Security Group for VPC Endpoint"
    vpc_id = aws_vpc.nextcloud_vpc.id
    tags = var.tags

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        description = "Allow HTTP traffic from ALB"
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
