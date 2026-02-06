module "vpc" {
  source       = "../../modules/vpc"
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  subnet_cidr  = var.public_subnet_cidr
  tags         = var.extra_tags
}

module "ec2" {
  source                      = "../../modules/ec2"
  project_name                = var.project_name
  instance_type               = var.instance_type
  instance_count              = var.instance_count
  vpc_id                      = module.vpc.vpc_id
  subnet_id                   = module.vpc.subnet_id
  ami_id                      = var.ami_id
  ami_architecture            = var.ami_architecture
  ssh_ingress_cidr_blocks     = var.ssh_ingress_cidr_blocks
  key_name                    = var.key_name
  iam_instance_profile        = var.iam_instance_profile
  associate_public_ip_address = var.associate_public_ip_address
  metadata_http_tokens        = var.metadata_http_tokens
  metadata_http_put_response_hop_limit = var.metadata_http_put_response_hop_limit
  tags                        = var.extra_tags
}

module "s3" {
  source             = "../../modules/s3"
  project_name       = var.project_name
  bucket_name        = var.s3_bucket_name
  versioning_enabled = var.s3_versioning_enabled
  force_destroy      = var.s3_force_destroy
  sse_algorithm      = var.s3_sse_algorithm
  kms_key_id         = var.s3_kms_key_id
  tags               = var.extra_tags
}
