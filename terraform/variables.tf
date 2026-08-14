variable "region" {
  description = "AWS region for the EKS cluster."
  type        = string
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
  default     = "devboard-eks"
}

variable "kubernetes_version" {
  description = "EKS Kubernetes version."
  type        = string
  default     = "1.34"
}

variable "node_instance_type" {
  description = "EC2 instance type for EKS worker nodes."
  type        = string
  default     = "t3.large"
}

variable "node_desired_size" {
  description = "Desired number of EKS worker nodes."
  type        = number
  default     = 3
}

variable "node_min_size" {
  description = "Minimum number of EKS worker nodes."
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum number of EKS worker nodes."
  type        = number
  default     = 4
}

variable "node_disk_size" {
  description = "Root disk size for each worker node in GiB."
  type        = number
  default     = 30
}

variable "enable_argocd" {
  description = "Enable Argo CD installation."
  type        = bool
  default     = true
}

variable "argocd_chart_version" {
  description = "Argo CD Helm chart version."
  type        = string
  default     = "7.8.26"
}
