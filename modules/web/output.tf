
output "taskDefinitionArn" {
  value = aws_ecs_task_definition.taskDefinition.arn
}

output "albDnsName" {
    value = aws_alb.main.dns_name
}