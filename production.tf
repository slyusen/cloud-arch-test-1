module "networking" {
  source               = "./modules/networking"
  region               = "${var.region}"
  environment          = "${var.environment}"
  vpc_cidr             = "${var.vpc_cidr}"
  public_subnets_cidr  = "${var.public_subnets_cidr}"
  private_subnets_cidr = "${var.private_subnets_cidr}"
  availability_zones   = "${var.availability_zones}"
}

module "web" {
  source                        = "./modules/web"
  vpc_id                        = module.networking.vpc_id
  public_subnet_ids             = module.networking.public_subnet_ids
  private_subnet_ids            = module.networking.private_subnet_ids
  alb_security_group_id         = module.networking.alb_security_group_id
  ecs_tasks_security_group_id   = module.networking.ecs_tasks_security_group_id
  region                        = "${var.region}"
  app_image                     = "${var.app_image}"
  app_port                      = "${var.app_port}"
  ecs_task_execution_role_name  = "${var.ecs_task_execution_role_name}"
  az_count                      = "${var.az_count}"
  app_count                     = "${var.app_count}"
  health_check_path             = "${var.health_check_path}"
  fargate_cpu                   = "${var.fargate_cpu}"
  fargate_memory                = "${var.fargate_memory}"
  profile                       = "${var.profile}"
}