variable "access_key" {
  type    = "string"
  default = ""
}

variable "secret_key" {
  type    = "string"
  default = ""
}

variable "region" {
  type    = "string"
  default = "us-east-2"
}

variable "ami" {
  type    = "string"
  default = "ami-0552e3455b9bc8d50"
# default = "ami-5e8bb23b"
}

variable "instance_type" {
  type    = "string"
  default = "t3.small"
}

variable "pem_file" {
  type    = "string"
  default = "~/aws/db_ec2_ohio_01.pem"
}

variable "public_ips" {
  type    = "list"
  default = [ "18.218.108.31", "18.222.164.199", "18.217.252.115" ]
}

# ips   = "${lookup(var.clientnode_instance_ips, count.index)}"
# hosts = "${element(aws_instance.clientnode.*.private_ip, count.index)}"

