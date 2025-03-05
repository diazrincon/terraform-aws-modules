variable "cluster_name" {
  type = string
}

variable "openid_provider_arn" {
  type = string
}

variable "cluster_asg_identifier" {
  type = string
}

variable "asg_maxsize" {
  type = string
}

variable "asg_minsize" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "us-west-2"
}
