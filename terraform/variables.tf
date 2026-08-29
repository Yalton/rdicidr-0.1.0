variable "aws_region" {
  type        = string
  description = "AWS region for deployment"
  default     = "us-east-1"
}

variable "app_name" {
  type        = string
  description = "Application name. Also the ECR repository and ECS family name."
  default     = "rdicidr"
}

variable "image_tag" {
  type        = string
  description = "Tag of the image to deploy from the ECR repository this configuration creates. Pass the commit SHA from CI for a reproducible deployment."
  default     = "latest"
}

variable "container_port" {
  type        = number
  description = "Port the container listens on"
  default     = 80
}

variable "alb_port" {
  type        = number
  description = "Port the load balancer listens on"
  default     = 80
}

variable "health_check_path" {
  type        = string
  description = "Health check endpoint path. Must be a path nginx.conf actually serves."
  default     = "/health"
}

variable "desired_count" {
  type        = number
  description = "Number of ECS tasks to run"
  default     = 2
}

variable "health_check_grace_period_seconds" {
  type        = number
  description = "Grace period before the load balancer health check can mark a newly started task unhealthy"
  default     = 60
}
