resource "aws_cloudwatch_log_group" "main" {
  name              = "/ecs/${var.name}-task-${var.environment}"
  retention_in_days = 14

  tags = {
    Name        = "${var.name}-task-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_metric_filter" "errors" {
  name           = "ErrorLogs"
  pattern        = "ERROR"
  log_group_name = aws_cloudwatch_log_group.main.name

  metric_transformation {
    name          = "ErrorsCount"
    namespace     = var.name
    value         = "1"
    default_value = "0"
  }
}
