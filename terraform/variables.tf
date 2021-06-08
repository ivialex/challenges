variable "minikube_cmd" {
  description = "Minikube Command"
  type        = string
  default     = "intall"
}

variable "minikube_prefix" {
  description = "Minikube Prefix"
  type        = string
  default     = "$HOME/local/bin"
}
