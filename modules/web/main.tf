
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
}

resource "aws_ecs_cluster" "mainCluster" {
  name = "web_app-cluster"
}

data "template_file" "web_app" {
  template = file("./modules/web/templates/ecs/web_app.json.tpl")

  vars = {
    app_image      = var.app_image
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    region         = var.region
    bucket_name    = var.bucket_name
  }
}

resource "aws_ecs_task_definition" "taskDefinition" {
  family                   = "web-app-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.web_app.rendered
}

resource "aws_ecs_service" "ecsService" {
  name            = "web-service"
  cluster         = aws_ecs_cluster.mainCluster.id
  task_definition = aws_ecs_task_definition.taskDefinition.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [var.ecs_tasks_security_group_id]
    subnets          = var.private_subnet_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "web-app"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}