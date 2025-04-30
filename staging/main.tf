module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  #subnet_cidr = var.subnet_cidr
}

module "sg" {
    source = "./modules/sg"
    vpc_id = module.vpc.vpc_id
}
module "eks" {
  source                  = "./modules/eks"
  subnet_ids              = module.vpc.subnet_ids
  vpc_id                  = module.vpc.vpc_id
  cluster_name            = "staging-eks-cluster1" #"module-eks-${random_string.suffix.result}"
  endpoint_public_access  = false
  endpoint_private_access = true
  public_access_cidrs     = ["0.0.0.0/0"]
  node_group_name         = "staging-eks-worker-node-group"
  scaling_desired_size    = 1
  scaling_max_size        = 2
  scaling_min_size        = 1
  instance_types          = ["t2.large"]
  key_pair                = "KeypairT"
}

module "ec2_jumpbox" {
  source            = "./modules/ec2-jumpbox"
  ami_id            = "ami-0eb302fcc77c2f8bd"  # Replace with valid AMI in your region
  instance_type     = "t3.micro"
  subnet_id         = module.vpc.subnet_ids
  security_group_id = module.sg.sg_id
  key_name          = "KeypairT"
}
