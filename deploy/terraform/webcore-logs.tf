# logs.tf
# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "demoapp_log_group" {
  name              = "/ecs/demoapp"
  retention_in_days = 30

  tags = {
    Name = "demoapp-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "cb_log_stream" {
  name           = "demoapp-log-stream"
  log_group_name = aws_cloudwatch_log_group.demoapp_log_group.name
}
