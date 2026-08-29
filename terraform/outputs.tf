output "alb_dns_name" {
  value       = aws_lb.app.dns_name
  description = "DNS name of the load balancer"
}

output "alb_url" {
  value       = "http://${aws_lb.app.dns_name}"
  description = "Base URL of the deployed application"
}

output "cluster_name" {
  value       = aws_ecs_cluster.main.name
  description = "ECS cluster name"
}

output "ecr_repository_url" {
  value       = aws_ecr_repository.app.repository_url
  description = "ECR repository URI to build and push images to"
}

output "ecs_service_name" {
  value       = aws_ecs_service.app.name
  description = "ECS service name, for aws ecs update-service"
}

output "task_definition_family" {
  value       = aws_ecs_task_definition.app.family
  description = "ECS task definition family"
}

output "aws_account_id" {
  value       = data.aws_caller_identity.current.account_id
  description = "Account the configuration is deployed into"
}
