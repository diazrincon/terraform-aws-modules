variable "cluster_name" {
  description = "The Cluster (EKS/ECS) name that will use the EFS filesystem"
  type        = string
}

variable "encrypted" {
  description = "Specifies whether the file system should be encrypted"
  default     = true
  type        = bool
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  description = "List of private subnets to create EFS mount targets"
  type        = list(string)
}
