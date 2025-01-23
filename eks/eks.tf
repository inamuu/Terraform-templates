module "eks" {
  source                         = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=769633253996237a79fe4c4cb49ec0eadfae5e69" # v20.26.1"
  cluster_name                   = local.eks_cluster_name
  cluster_version                = "1.31"
  cluster_endpoint_public_access = true

  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler",
  ]

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id     = data.aws_vpc.this.id
  subnet_ids = local.eks_subnet_ids

  eks_managed_node_group_defaults = {
    instance_types = ["t4g.medium"]
    disk_size      = 20
    subnet_ids     = local.eks_subnet_ids
  }

  eks_managed_node_groups = {
    node01 = {
      ami_type     = "AL2023_ARM_64_STANDARD"
      min_size     = 1
      max_size     = 1
      desired_size = 1
      labels = {
        "app.kubernetes.io/instance" = "aws-load-balancer-controller"
      }
    }
  }

  enable_cluster_creator_admin_permissions = true

  tags = {
    Environment = "stg"
    Terraform   = "true"
    #"karpenter.sh/discovery" = "karpenter" # Karpenter導入時に有効化
  }
}

# FargateProfile
module "eks_fargate_profile" {
  source = "terraform-aws-modules/eks/aws//modules/fargate-profile"

  name         = "example"
  cluster_name = "example"

  subnet_ids = local.eks_subnet_ids

  # 後からだと追加できない
  selectors = [{
    namespace = "kube-system"
  }]

  tags = {
    Environment = "stg"
    Terraform   = "true"
  }
}
