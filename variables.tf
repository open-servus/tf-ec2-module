variable "environment" {}

variable "project_name" {}

variable "aws_instance_type" {}

variable "aws_key_pair" {}

variable "sg_instance_group_ids" {}

variable "aws_ami" {}

variable "availability_zone" {}

variable "eip_enabled" {
    type = bool
    default = false
}