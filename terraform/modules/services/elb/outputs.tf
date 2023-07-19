output "aws_alb_target_group_arn" {
  value = aws_alb_target_group.demo_alb_tg.arn
}

output "elb_domain" {
  value = aws_lb.demo_alb.dns_name
}
