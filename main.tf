module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source         = "./ec2"
  subnet1        = module.vpc.subnet1_id
  subnet2        = module.vpc.subnet2_id
  security_group = module.vpc.aws_security_group
}

module "alb" {
  source         = "./alb"
  subnet1        = module.vpc.subnet1_id
  subnet2        = module.vpc.subnet2_id
  security_group = module.vpc.aws_security_group
  vpc_id         = module.vpc.vpc_id
  instance_id1   = module.ec2.instance_id1
  instance_id2   = module.ec2.instance_id2
}


