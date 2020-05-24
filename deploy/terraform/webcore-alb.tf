# alb.tf
resource "aws_alb" "demoapp_lb" {
  name            = "dev-demoapp"
  subnets         = [data.aws_subnet.public_1a.id,data.aws_subnet.public_1b.id,data.aws_subnet.public_1c.id]
  security_groups = [aws_security_group.lb.id]
}

resource "aws_alb_target_group" "demoapp_target" {
  name        = "demoapp-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      =  data.aws_vpc.main.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.demoapp_health_check_path
    unhealthy_threshold = "2"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end_demoapp" {
  load_balancer_arn = aws_alb.demoapp_lb.id
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.demoapp_target.id
    type             = "forward"
  }
}

