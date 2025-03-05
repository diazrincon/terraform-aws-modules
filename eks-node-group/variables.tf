variable "base_name" {
  type = string
}

variable "tags" {
  type = map(string)
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

variable "cluster_name" {
  type = string
}

variable "cluster_ca" {
  type = string
}

variable "cluster_endpoint" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "service_ipv4_cidr" {
  type = string
}

variable "node_sgs" {
  type = list(string)
}

variable "instance_types" {
  type    = list(string)
  default = ["t3.medium", "t3.large"]
}

variable "storage_size" {
  type    = number
  default = 30
}

variable "desired_size" {
  type    = number
  default = 0
}

variable "max_size" {
  type    = number
  default = 10
}

variable "min_size" {
  type    = number
  default = 0
}

variable "update_default_version" {
  type    = bool
  default = false
}

variable "node_iam_policies" {
  description = "List of IAM Policies to attach to EKS-managed nodes."
  type        = map(string)
  default = {
    AmazonEKSWorkerNodePolicy          = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    AmazonEKS_CNI_Policy               = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    CloudWatchAgentServerPolicy        = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
    AmazonSSMManagedInstanceCore       = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
}
