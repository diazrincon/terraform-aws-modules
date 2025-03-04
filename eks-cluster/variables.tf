variable "kubernetes_version" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_policies" {
  type = map(string)
  default = {
    AmazonEKSClusterPolicy = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    AmazonEKSServicePolicy = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  }
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "public_access_cidrs" {
  type    = list(string)
  default = []
}

variable "endpoint_public_access" {
  type    = bool
  default = false
}

variable "endpoint_private_access" {
  type    = bool
  default = true
}

variable "enabled_cluster_log_types" {
  type        = list(string)
  description = "Valid values api, audit, authenticator, controllerManager, scheduler"
  default     = []
}

variable "enable_irsa" {
  description = "Determines whether to create an OpenID Connect Provider for EKS to enable IRSA"
  type        = bool
  default     = true
}

variable "cluster_sg" {
  type = string
}

variable "workstation_access_entry" {
  type = object({
    enabled    = bool
    role_arn   = string
    policy_arn = string
  })

  default = {
    enabled    = false
    role_arn   = ""
    policy_arn = ""
  }
}
variable "bitbucket_inbound_cidrs" {
  type = list(string)
}
variable "bitbucket_outbound_cidrs" {
  type = list(string)
}
