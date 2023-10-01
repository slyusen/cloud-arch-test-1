variable "region" {
  description = "AWS Deployment region.."
  default = "us-east-1"
}

variable "profile" {
  description = "AWS Deployment profile.."
  default = "default"
}

variable "environment" {
  description = "AWS Deployment environment.."
  default = "dev"
}

variable "vpc_cidr" {
  description = "AWS Deployment vpc cidr.."
  default = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  description = "AWS Deployment vpc cidr.."
  type = list
  default = ["10.0.1.0/24"]
}

variable "private_subnets_cidr" {
  description = "AWS Deployment vpc cidr.."
  type = list
  default = ["10.0.2.0/24"]
}

variable "availability_zones" {
    type = list
    default = ["us-east-1a", "us-east-1b"]
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "myEcsTaskExecutionRole"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "nginx:latest"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}