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

variable "lb_name" {
  type = string
}

variable "listener_rules" {
  type = map(object({
    priority             = number
    host_header          = string
    target_group_name    = string
    health_check_enabled = bool
    health_check_path    = string
  }))
}
