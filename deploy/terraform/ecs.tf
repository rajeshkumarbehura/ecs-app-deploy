# ecs.tf
resource "aws_ecs_cluster" "main" {
  name = "${var.prefix}-api-cluster"
}
