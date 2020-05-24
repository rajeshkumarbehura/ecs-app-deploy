# outputs.tf

output "demoapp_alb_hostname" {
  value = aws_alb.demoapp_lb.dns_name
}

