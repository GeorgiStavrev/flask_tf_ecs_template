variable "region" {
  description = "AWS region."
}

variable "alb" {
  description = "EC2 Application Load Balancer Id."
}


variable "ecs_service" {
  description = "ECS service the dashboard will show display for."
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster the dashboard will show display for."
}

