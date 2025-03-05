variable "public_zone_name" {
  type    = string
  default = ""
}

variable "private_zone_name" {
  type    = string
  default = ""
}

variable "domain_name" {
  type = string
}

variable "subject_alternative_names" {
  type = list(string)
}

variable "wait_validation" {
  type    = bool
  default = false
}
