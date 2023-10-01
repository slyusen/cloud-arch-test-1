# logs.tf

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "web_app_log_group" {
  name              = "/ecs/web-app"
  retention_in_days = 30

  tags = {
    Name = "web-app-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "web_app_log_stream" {
  name           = "web-app-log-stream"
  log_group_name = aws_cloudwatch_log_group.web_app_log_group.name
}