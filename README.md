# AWS RDS Terraform module

Terraform module which create RDS resources on AWS.

## Usage
```hcl
module "rds" {
  source = "github.com/antonioazambuja/terraform-aws-rds"
  vpc_id = "vpc-id"
  name = "my-test"
  engine = "postgre"
  username = "postgres"
  password = "postgres"
  db_name = "postgres"
  instance_class = "t3.small"
  engine_version = "9.6.1"
  allocated_storage = 50
  skip_final_snapshot = true
  subnets = ["subnet-id-1", "subnet-id-2"]
  security_group_rules = [
    {
      cidr_blocks = ["0.0.0.0/0"],
      description = "Global access"
      from_port = 0
      to_port = 0
      protocol = "-1"
      type = "ingress"
      self = false
      source_security_group_id = ""
    }
  ]
  security_group_tags = {
    Project = "TEST"
  }
  rds_tags = {
    Project = "TEST"
  }
}
```