output "lb_dns_name" {
  description = "DNS Name for the ALB"
  value       = module.alb.lb_dns_name
}

output "http_listener_arn" {
  description = "HTTP Listener ARN"
  value       = module.alb.http_tcp_listener_arns[0]
}
