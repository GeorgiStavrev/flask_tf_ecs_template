resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.ecs_service.name}-OperationalMetrics"

  dashboard_body = <<EOF
{
    "widgets": [
        {
            "height": 6,
            "width": 6,
            "y": 0,
            "x": 6,
            "type": "metric",
            "properties": {
                "period": 300,
                "region": "${var.region}",
                "stacked": false,
                "title": "CPU utilization",
                "view": "timeSeries",
                "yAxis": {
                    "left": {
                        "showUnits": true
                    }
                },
                "start": "-PT72H",
                "timezone": "UTC",
                "end": "P0D",
                "metrics": [
                    [ "AWS/ECS", "CPUUtilization", "ServiceName", "${var.ecs_service.name}", "ClusterName", "${var.ecs_cluster_name}", { "stat": "Average" } ]
                ]
            }
        },
        {
            "height": 6,
            "width": 6,
            "y": 6,
            "x": 6,
            "type": "metric",
            "properties": {
                "period": 300,
                "region": "${var.region}",
                "stacked": false,
                "title": "Memory utilization",
                "view": "timeSeries",
                "yAxis": {
                    "left": {
                        "showUnits": true
                    }
                },
                "start": "-PT72H",
                "timezone": "UTC",
                "end": "P0D",
                "metrics": [
                    [ "AWS/ECS", "MemoryUtilization", "ServiceName", "${var.ecs_service.name}", "ClusterName", "${var.ecs_cluster_name}" ]
                ]
            }
        },
        {
            "height": 6,
            "width": 6,
            "y": 6,
            "x": 18,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "AWS/Usage", "ResourceCount", "Type", "Resource", "Resource", "Spot", "Service", "Fargate", "Class", "None", { "label": "Fargate Spot Usage" } ]
                ],
                "period": 300,
                "region": "${var.region}",
                "stacked": false,
                "title": "FARGATE Spot Usage",
                "view": "timeSeries",
                "yAxis": {
                    "left": {
                        "showUnits": true
                    }
                },
                "timezone": "UTC",
                "stat": "Average"
            }
        },
        {
            "height": 6,
            "width": 6,
            "y": 0,
            "x": 18,
            "type": "metric",
            "properties": {
                "metrics": [
                    [ "AWS/Usage", "ResourceCount", "Type", "Resource", "Resource", "vCPU", "Service", "Fargate", "Class", "Standard/Spot", { "label": "Fargate Spot vCPU Usage" } ]
                ],
                "period": 300,
                "region": "${var.region}",
                "stacked": false,
                "title": "FARGATE Spot vCPU Usage",
                "view": "timeSeries",
                "yAxis": {
                    "left": {
                        "showUnits": true
                    }
                },
                "start": "-PT72H",
                "timezone": "UTC",
                "end": "P0D",
                "stat": "Average"
            }
        },
        {
            "height": 6,
            "width": 6,
            "y": 0,
            "x": 12,
            "type": "metric",
            "properties": {
                "period": 300,
                "region": "${var.region}",
                "stacked": false,
                "title": "ALB Request Count",
                "view": "timeSeries",
                "yAxis": {
                    "left": {
                        "showUnits": true
                    }
                },
                "timezone": "UTC",
                "stat": "Average",
                "metrics": [
                    [ "AWS/ApplicationELB", "RequestCount", "LoadBalancer", "${var.alb.arn_suffix}" ]
                ]
            }
        },
        {
            "height": 6,
            "width": 6,
            "y": 6,
            "x": 12,
            "type": "metric",
            "properties": {
                "period": 300,
                "region": "${var.region}",
                "stacked": false,
                "title": "ALB New Connections Count",
                "view": "timeSeries",
                "yAxis": {
                    "left": {
                        "showUnits": true
                    }
                },
                "timezone": "UTC",
                "stat": "Average",
                "metrics": [
                    [ "AWS/ApplicationELB", "NewConnectionCount", "LoadBalancer", "${var.alb.arn_suffix}" ]
                ]
            }
        },
        {
            "height": 6,
            "width": 6,
            "y": 12,
            "x": 12,
            "type": "metric",
            "properties": {
                "period": 300,
                "region": "${var.region}",
                "stacked": false,
                "title": "ALB Active Connections Count",
                "view": "timeSeries",
                "yAxis": {
                    "left": {
                        "showUnits": true
                    }
                },
                "timezone": "UTC",
                "stat": "Average",
                "metrics": [
                    [ "AWS/ApplicationELB", "ActiveConnectionCount", "LoadBalancer", "${var.alb.arn_suffix}" ]
                ]
            }
        },
        {
            "height": 6,
            "width": 6,
            "y": 0,
            "x": 0,
            "type": "metric",
            "properties": {
                "period": 300,
                "region": "${var.region}",
                "stacked": false,
                "title": "Application Response Time",
                "view": "timeSeries",
                "yAxis": {
                    "left": {
                        "showUnits": true
                    }
                },
                "timezone": "UTC",
                "stat": "Average",
                "metrics": [
                    [ "AWS/ApplicationELB", "TargetResponseTime", "LoadBalancer", "${var.alb.arn_suffix}" ]
                ]
            }
        },
        {
            "height": 6,
            "width": 6,
            "y": 6,
            "x": 0,
            "type": "metric",
            "properties": {
                "period": 300,
                "region": "${var.region}",
                "stacked": false,
                "title": "Application Response Codes",
                "view": "timeSeries",
                "yAxis": {
                    "left": {
                        "showUnits": true
                    }
                },
                "timezone": "UTC",
                "stat": "Average",
                "metrics": [
                    [ "AWS/ApplicationELB", "HTTPCode_Target_5XX_Count", "LoadBalancer", "${var.alb.arn_suffix}" ],
                    [ ".", "HTTPCode_Target_2XX_Count", ".", "." ],
                    [ ".", "HTTPCode_Target_4XX_Count", ".", "." ]
                ]
            }
        },
        {
            "height": 6,
            "width": 6,
            "y": 12,
            "x": 6,
            "type": "metric",
            "properties": {
                "period": 300,
                "region": "${var.region}",
                "stacked": false,
                "title": "ALB Processed Bytes",
                "view": "timeSeries",
                "yAxis": {
                    "left": {
                        "showUnits": true
                    }
                },
                "timezone": "UTC",
                "stat": "Average",
                "metrics": [
                    [ "AWS/ApplicationELB", "ProcessedBytes", "LoadBalancer", "${var.alb.arn_suffix}" ]
                ]
            }
        }
    ]
}
EOF
}