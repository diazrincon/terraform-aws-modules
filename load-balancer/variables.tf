variable "vpc_id" {
  type = string
}

variable "name" {
  type = string
}

variable "internal" {
  type    = bool
  default = false
}

variable "security_groups" {
  type = list(string)
}

variable "default_certificate_arn" {
  type = string
}

variable "additional_certificate_arns" {
  type    = list(string)
  default = []
}

variable "access_logs_bucket" {
  type = string
}
