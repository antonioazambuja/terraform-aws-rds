resource "aws_security_group" "rds" {
  name   = var.name
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.security_group_tags, { Name=var.name })
}

resource "aws_db_subnet_group" "rds" {
  name       = "main"
  subnet_ids = var.subnets

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_security_group_rule" "rds_cidr_block_rules" {
  for_each          = { for rule in var.security_group_rules: rule.description => rule if rule.source_security_group_id == "" || !rule.self && length(rule.cidr_blocks) > 0 }
  security_group_id = aws_security_group.rds.id
  cidr_blocks       = each.value.cidr_blocks
  description       = each.value.description
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  type              = each.value.type
}

resource "aws_security_group_rule" "rds_source_security_group_id_rules" {
  for_each                 = { for rule in var.security_group_rules: rule => rule if length(rule.cidr_blocks) == 0 || !rule.self && rule.source_security_group_id != "" }
  security_group_id        = aws_security_group.rds.id
  source_security_group_id = each.value.source_security_group_id
  description              = each.value.description
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  type                     = each.value.type
}

resource "aws_security_group_rule" "rds_self_rules" {
  for_each          = { for rule in var.security_group_rules: rule => rule if length(rule.cidr_blocks) == 0 || rule.source_security_group_id == "" && rule.self }
  security_group_id = aws_security_group.rds.id
  self              = each.value.self
  description       = each.value.description
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  type              = each.value.type
}

resource "aws_db_instance" "rds" {
  db_subnet_group_name   = aws_db_subnet_group.rds.name
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  name                   = var.db_name
  username               = var.username
  password               = var.password
  skip_final_snapshot    = var.skip_final_snapshot
  vpc_security_group_ids = [ aws_security_group.rds.id ]
  tags                   = merge(var.rds_tags, { Name=var.name })
}