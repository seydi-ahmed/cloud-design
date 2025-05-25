variable "cluster_name" {
  description = "Nom du cluster EKS"
  type        = string
}

variable "region" {
  description = "Région AWS"
  type        = string
}

variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR du VPC"
  type        = string
}
