# variables.tf

variable "prefix" {
  description = "Prefix for all envirnoments"
  default     = "demoapp"
}

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "ap-southeast-1"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "demoappEcsTaskExecutionRole"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "3"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 2
}

####  Commented becoz of it uses Envirnoment variable.
variable "demoapp_image" {
  description = "Docker image to run in the ECS cluster"
  // default     = "XXXXXXXXXX.dkr.ecr.ap-southeast-1.amazonaws.com/dev-demoapp:0.0.4"
}

variable "demoapp_health_check_path" {
  default = "/api/index"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

variable "demoapp_container_name" {
  description = "Application container name"
  default     = "demoapp-app"
}
