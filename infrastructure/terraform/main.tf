module "iam" {
  source = "../iam"

  cluster_name = var.cluster_name
}

module "eks" {
  source = "../eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  region          = var.region

  eks_cluster_role_arn         = module.iam.eks_cluster_role_arn
  eks_policy_attachment_id     = module.iam.eks_cluster_policy_attachment_id
  node_role_arn                = module.iam.eks_node_role_arn
  node_policy_attachment_id    = module.iam.eks_node_policy_attachment_id
  cni_policy_attachment_id     = module.iam.eks_cni_policy_attachment_id
  registry_policy_attachment_id = module.iam.eks_registry_policy_attachment_id

  ec2_key_pair = var.ec2_key_pair
}

module "networking" {
  source = "../networking"

  cluster_name    = var.cluster_name
  region          = var.region

  vpc_id           = module.eks.vpc_id
  vpc_cidr_block   = module.eks.vpc_cidr_block
}
