variable "vpc_id" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "public_access_cidrs_eks" {
  type    = list(string)
  default = []
}

variable "public_access_cidrs_alb" {
  type    = list(string)
  default = []
}

variable "mabl_cidrs" {
  type    = list(string)
  default = []
}

variable "bitbucket_inbound_cidrs" {
  type = list(string)
}
variable "bitbucket_outbound_cidrs" {
  type = list(string)
}
