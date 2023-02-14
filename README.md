# tf-ec2-module
Terraform aws EC2 Instance.

How to use it:
```
module "admin" {
  source            = "git::https://github.com/open-servus/tf-ec2-module.git?ref=main"
  project_name      = "openservus-admin"
  environment       = "prod"
  aws_key_pair       = module.bootstrap.aws_key_pair
  sg_instance_group_ids  = [module.sg.sg_admin,module.sg.sg_whitelist]
  aws_ami            = module.data.aws_ami
  availability_zone  = module.data.aws_availability_zone
  aws_instance_type  = module.data.aws_instance_type.general

}
```