output "image" {
  value = var.container_image
}

output "image_tag" {
  value = var.container_image_tag
}

output "ecs_service" {
  value = aws_ecs_service.main
}

output "cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.main
}