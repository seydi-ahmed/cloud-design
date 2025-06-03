output "cluster_name" {
  value = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.main.certificate_authority[0].data
}

# output "cluster_oidc_issuer_id" {
#   value = replace(aws_eks_cluster.main.identity[0].oidc[0].issuer, "https://oidc.eks.${var.region}.amazonaws.com/id/", "")
# }

output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "node_group_iam_role_arn" {
  value = var.node_role_arn
}

output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.eks.arn
}
