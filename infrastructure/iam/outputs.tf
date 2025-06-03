output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "eks_cluster_policy_attachment_id" {
  value = aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy.id
}

output "eks_node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}

output "eks_node_policy_attachment_id" {
  value = aws_iam_role_policy_attachment.eks_node_AmazonEKSWorkerNodePolicy.id
}

output "eks_cni_policy_attachment_id" {
  value = aws_iam_role_policy_attachment.eks_node_AmazonEKS_CNI_Policy.id
}

output "eks_registry_policy_attachment_id" {
  value = aws_iam_role_policy_attachment.eks_node_AmazonEC2ContainerRegistryReadOnly.id
}

output "node_group_iam_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}
