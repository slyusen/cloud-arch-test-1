region="us-east-1"
profile="default"
environment="dev"

/* module networking */
vpc_cidr             = "10.0.0.0/16"
public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"] //List of Public subnet cidr range
private_subnets_cidr = ["10.0.10.0/24"] //List of private subnet cidr range
availability_zones=["us-east-1a", "us-east-1b"]
app_image="412991794543.dkr.ecr.us-east-1.amazonaws.com/web-app-repo:latest"
