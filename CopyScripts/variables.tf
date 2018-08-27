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
  default = "ami-5e8bb23b"
}

variable "instance_type" {
  type    = "string"
  default = "t2.small"
}

variable "pem_file" {
  type    = "string"
  default = "/home/dthompson/aws/db_ec2_ohio_01.pem"
}

variable "public_ips" {
  type    = "list"
  default = [ "18.191.205.168", "18.223.108.42", "13.58.232.95" ]
}

# ips   = "${lookup(var.clientnode_instance_ips, count.index)}"
# hosts = "${element(aws_instance.clientnode.*.private_ip, count.index)}"

