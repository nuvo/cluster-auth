variable "name" {
  description = "Group name"
  default     = "k8s-access"
}

variable "users" {
  description = "Users to be granted access to Kubernetes"
  type        = "list"
  default     = []
}
