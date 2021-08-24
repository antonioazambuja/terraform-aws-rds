output "security_group_id" {
  value = aws_security_group.rds.id
}

output "security_group_arn" {
  value = aws_security_group.rds.arn
}

output "db_subnet_group_id" {
  value = aws_db_subnet_group.rds.id
}

output "db_subnet_group_arn" {
  value = aws_db_subnet_group.rds.arn
}

output "db_instance_arn" {
  value = aws_db_instance.rds.arn
}

output "db_instance_endpoint" {
  value = aws_db_instance.rds.endpoint
}

output "db_instance_engine" {
  value = aws_db_instance.rds.engine
}

output "db_instance_engine_version" {
  value = aws_db_instance.rds.engine_version
}

output "db_instance_id" {
  value = aws_db_instance.rds.id
}

output "db_instance_instance_class" {
  value = aws_db_instance.rds.instance_class
}

output "db_instance_port" {
  value = aws_db_instance.rds.port
}