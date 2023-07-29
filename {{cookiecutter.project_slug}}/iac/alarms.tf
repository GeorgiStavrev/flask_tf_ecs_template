locals {
  alarms_sns_topic = data.aws_sns_topic.alarms_shared
}


resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name  = "High CPU (ECS Cluster: ${local.ecs_cluster_name} | Service: ${module.ecs.ecs_service.name})"
  namespace   = "AWS/ECS"
  metric_name = "CPUUtilization"
  dimensions = {
    ClusterName = local.ecs_cluster_name
    ServiceName = local.ecs_cluster_name
  }
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "5"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "80"
  unit                      = "Percent"
  datapoints_to_alarm       = 5
  alarm_description         = "This metric monitors CPU utilization for the following ECS Cluster and service: ${local.ecs_cluster_name} ${module.ecs.ecs_service.name}. If the CPU usage exceeds 80%, you'll get an alert."
  insufficient_data_actions = []
  treat_missing_data        = "notBreaching"

  ok_actions    = [local.alarms_sns_topic.arn]
  alarm_actions = [local.alarms_sns_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "high_memory" {
  alarm_name  = "High Memory (ECS Cluster: ${local.ecs_cluster_name} | Service: ${module.ecs.ecs_service.name})"
  namespace   = "AWS/ECS"
  metric_name = "MemoryUtilization"
  dimensions = {
    ClusterName = local.ecs_cluster_name
    ServiceName = local.ecs_cluster_name
  }
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "80"
  unit                      = "Percent"
  datapoints_to_alarm       = 3
  alarm_description         = "This metric monitors Memory utilization for the following ECS Cluster and service: ${local.ecs_cluster_name} ${module.ecs.ecs_service.name}. If the CPU usage exceeds 80%, you'll get an alert."
  insufficient_data_actions = []
  treat_missing_data        = "notBreaching"

  ok_actions    = [local.alarms_sns_topic.arn]
  alarm_actions = [local.alarms_sns_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "increased_number_of_error" {
  alarm_name  = "Increased Number of Errors (ECS Cluster: ${local.ecs_cluster_name} | Service: ${module.ecs.ecs_service.name})"
  namespace   = var.name
  metric_name = "ErrorsCount"


  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "3"
  period                    = "60"
  statistic                 = "Sum"
  threshold                 = "5"
  datapoints_to_alarm       = 3
  alarm_description         = "This metric monitors the number of application errors from service: ${local.ecs_cluster_name} ${module.ecs.ecs_service.name}. If there are more than 3 consecutive minutes with 5 of more errors the alarm is triggered."
  insufficient_data_actions = []
  treat_missing_data        = "notBreaching"

  ok_actions    = [local.alarms_sns_topic.arn]
  alarm_actions = [local.alarms_sns_topic.arn]
}