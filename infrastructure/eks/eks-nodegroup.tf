resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.medium"]
  ami_type       = "AL2_x86_64"

  remote_access {
    ec2_ssh_key = var.ec2_key_pair
  }

  tags = {
    Name = "${var.cluster_name}-node-group"
  }

  depends_on = [
    aws_eks_cluster.main,
    var.node_policy_attachment_id,
    var.cni_policy_attachment_id,
    var.registry_policy_attachment_id
  ]
}
