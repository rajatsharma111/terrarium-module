provider "aws" {
  region = "us-west-2"
}

module "private_subnets" {
  source = "./modules/private_subnets"

  vpc_cidr_block       = "10.0.0.0/16"
  private_subnet_count = 2
  subnet_cidr_blocks   = ["10.0.1.0/24", "10.0.2.0/24"]
}

module "private_subnet" {
  source             = "./modules/private_subnet"
  subnet_cidr_block  = "10.0.3.0/24"
  availability_zone  = "us-west-2a"
  vpc_id             = module.private_subnets.vpc_id
  private_subnet_ids = module.private_subnets.private_subnet_ids
}
