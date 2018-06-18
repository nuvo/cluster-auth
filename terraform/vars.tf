variable "name" {
  description = "Role name"
  default     = "k8s-access"
}

variable "description" {
  description = "Role description"
  default     = "Kubernetes role for Heptio Authenticator for AWS"
}

variable "users" {
  description = "Users to be granted access to Kubernetes"
  type        = "list"
  default     = []
}
