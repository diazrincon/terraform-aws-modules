variable "vpc_id" {
  type = string
}

variable "zone_name" {
  type = string
}

variable "zone_type" {
  type    = string
  default = "public"
}

variable "domain_name" {
  type = string
}

variable "wait_validation" {
  type    = bool
  default = false
}
