variable "aws_region" {
  type = string
}

variable "environment" {
  type = string
}

variable "subnet_group_ids" {
  type = list(string)
}

variable "security_group" {
  type = string
}
