variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type    = string
  default = "1.29"
}

variable "region" {
  type = string
}

variable "eks_cluster_role_arn" {
  description = "ARN du rôle IAM pour le cluster EKS"
  type        = string
}

variable "eks_policy_attachment_id" {
  description = "ID de l'attachement de la policy IAM pour EKS"
  type        = string
}

variable "node_role_arn" {
  description = "ARN du rôle IAM pour les nodes EKS"
  type        = string
}

variable "node_policy_attachment_id" {
  description = "Policy attachment pour AmazonEKSWorkerNodePolicy"
  type        = string
}

variable "cni_policy_attachment_id" {
  description = "Policy attachment pour AmazonEKSCNIPolicy"
  type        = string
}

variable "registry_policy_attachment_id" {
  description = "Policy attachment pour AmazonEC2ContainerRegistryReadOnly"
  type        = string
}

variable "ec2_key_pair" {
  description = "The name of the EC2 Key Pair to allow SSH access to the nodes"
  type        = string
}
