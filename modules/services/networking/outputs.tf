output "public_subnet_a_id" {
  value = aws_subnet.public_subnet_a.id
}

output "public_subnet_b_id" {
  value = aws_subnet.public_subnet_b.id
}

output "public_subnets"{
  value = [
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_b.id
  ]
}

output "private_subnet_ecs_id" {
  value = aws_subnet.private_subnet_ecs.id
}

output "private_subnet_db_ids" {
  value = [
    aws_subnet.private_subnet_db_a.id,
    aws_subnet.private_subnet_db_b.id
  ]
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.db_subnet_group.name
}
