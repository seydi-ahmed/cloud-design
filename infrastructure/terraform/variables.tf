variable "aws_region" {
  description = "La région AWS où déployer les ressources"
  type        = string
  default     = "eu-west-3"  # Paris
}

variable "aws_profile" {
  description = "Le profil AWS CLI à utiliser"
  type        = string
  default     = "default"
}

variable "cluster_name" {
  description = "Nom du cluster EKS"
  type        = string
  default     = "cloud-design-cluster"
}

variable "node_instance_type" {
  description = "Type d'instance EC2 pour les nœuds du cluster"
  type        = string
  default     = "t3.medium"
}

variable "desired_capacity" {
  description = "Nombre de nœuds souhaités au démarrage"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Nombre minimum de nœuds"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Nombre maximum de nœuds"
  type        = number
  default     = 5
}
