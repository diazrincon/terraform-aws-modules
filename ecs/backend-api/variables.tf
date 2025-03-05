variable "vpc_id" {
  type = string
}

variable "external_target_group_name" {
  type = string
}

variable "internal_target_group_name" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "security_groups" {
  type = list(string)
}

variable "ecs_service_name" {
  type = string
}

variable "ecs_task_definition_name" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_image" {
  type = string
}

variable "task_cpu" {
  type = number
}

variable "task_memory" {
  type = number
}

variable "desired_count" {
  type = number
}

variable "log_retention_days" {
  type    = number
  default = 14
}

variable "efs_file_system_id" {
  type    = string
  default = ""
}

variable "app_configuration_secret" {
  type    = string
  default = ""
}

variable "enable_additional_task_execution_policy" {
  type    = bool
  default = false
}

variable "enable_additional_task_policy" {
  type    = bool
  default = false
}

variable "additional_task_execution_policy" {
  type    = string
  default = ""
}

variable "additional_task_policy" {
  type    = string
  default = ""
}
