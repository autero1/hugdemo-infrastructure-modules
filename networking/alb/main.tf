module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${var.name}-alb-sg"
  description = "Security group for ${var.name} ALB"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = var.allow_connections_from_cidr_blocks
  ingress_rules       = ["http-80-tcp"]
  egress_rules        = ["all-all"]

  tags = var.common_tags
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "6.5.0"

  name = "${var.name}-alb"

  load_balancer_type = "application"

  vpc_id          = var.vpc_id
  security_groups = [module.security_group.security_group_id]
  subnets         = var.vpc_subnet_ids

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "fixed-response"
      fixed_response = {
        content_type = "text/plain"
        message_body = "Not found"
        status_code  = "404"
      }
    }
  ]

  tags = var.common_tags
}