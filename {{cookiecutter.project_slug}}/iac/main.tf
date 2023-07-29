provider "aws" {}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.54.0"
    }
  }

  backend "s3" {}
}

locals {
  ecs_cluster_name      = "shared-cluster"
  alarms_sns_topic_name = "shared-alarms-topic"
}


data "aws_vpc" "shared" {
  id = var.vpc_id
}

data "aws_subnet" "private" {
  availability_zone = element(var.availability_zones, count.index)
  vpc_id            = var.vpc_id
  state             = "available"
  filter {
    name   = "tag:Tier"
    values = ["Private"]
  }
  count = length(var.availability_zones)
}

data "aws_security_groups" "shared" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["atKairos-sg-task-shared"]
  }
}

data "aws_lb" "shared" {
  name = var.lb_name
}

data "aws_lb_listener" "shared443" {
  load_balancer_arn = data.aws_lb.shared.arn
  port              = 443
}

data "aws_ecs_cluster" "shared" {
  cluster_name = local.ecs_cluster_name
}

data "aws_sns_topic" "alarms_shared" {
  name = local.alarms_sns_topic_name
}

resource "aws_alb_target_group" "service" {
  depends_on  = [data.aws_lb.shared]
  name        = "${var.name}-tg-${var.environment}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "${var.name}-tg-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_lb_listener_rule" "subdomain_to_tg" {
  listener_arn = data.aws_lb_listener.shared443.arn
  priority     = var.lb_listener_rule_priority

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.service.arn
  }

  condition {
    host_header {
      values = ["{{cookiecutter.project_slug}}.com"]
    }
  }
}

module "ecr" {
  source = "./modules/ecr"
  name   = var.name
}

module "ecs" {
  source                      = "./modules/ecs"
  name                        = var.name
  environment                 = var.environment
  region                      = var.region
  subnets                     = data.aws_subnet.private
  aws_alb_target_group_arn    = aws_alb_target_group.service.arn
  ecs_cluster_name            = local.ecs_cluster_name
  ecs_service_security_groups = data.aws_security_groups.shared
  container_port              = var.container_port
  container_cpu               = var.container_cpu
  container_memory            = var.container_memory
  service_desired_count       = var.service_desired_count
  container_environment = [
    { name = "LOG_LEVEL",
    value = "DEBUG" },
    { name = "PORT",
    value = var.container_port },
    { name = "ENV", value = var.environment }
  ]
  container_image        = module.ecr.aws_ecr_repository_url
  container_image_tag    = substr(var.git_sha, 0, 7)
}

module "cw_dashboard" {
  source           = "./modules/cw_dashboard"
  region           = var.region
  ecs_service      = module.ecs.ecs_service
  ecs_cluster_name = local.ecs_cluster_name
  alb              = data.aws_lb.shared
}