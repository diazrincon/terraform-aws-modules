variable "vpc_id" {
  type = string
}

variable "efs_name" {
  type = string
}

variable "encrypted" {
  type    = bool
  default = true
}

variable "security_groups" {
  type = list(string)
}
