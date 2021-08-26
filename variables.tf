variable "name" {
  description = "RDS Name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "engine" {
  description = "Engine your RDS"
  type        = string
}

variable "username" {
  description = "Database Username"
  type        = string
}

variable "password" {
  description = "Database Password"
  type        = string
}

variable "db_name" {
  description = "Database Name"
  type        = string
}

variable "instance_class" {
  description = "Instance Class"
  type        = string
}

variable "engine_version" {
  description = "Engine Version"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated Storage"
  type        = number
}

variable "skip_final_snapshot" {
  description = "Enable or disable skip final snapshot"
  type        = bool
}

variable "subnets" {
  description = "Subnets of RDS"
  type        = list
}

variable "security_group_tags" {
  description = "A map of tags to assign to the AWS Security Group."
  type        = map
  default     = {}
  validation {
    condition     = length(var.security_group_tags) > 0
    error_message = "Tags from AWS Security Group is empty."
  }
}

variable "rds_tags" {
  description = "A map of tags to assign to the AWS RDS."
  type        = map
  default     = {}
  validation {
    condition     = length(var.rds_tags) > 0
    error_message = "Tags from AWS RDS is empty."
  }
}

variable "security_group_rules" {
  description = "Rules of RDS Security Group"
  type = list(object({
    cidr_blocks = list(string)
    description = string
    from_port = number
    to_port = number
    protocol = string
    source_security_group_id = string
    self = bool
    type = string
  }))
  default = [{
    cidr_blocks       = ["0.0.0.0/0"]
    description       = "Allow communicate to any IP."
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    source_security_group_id = ""
    self = false
    type              = "ingress"
  }]
}