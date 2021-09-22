
data "aws_dynamodb_table" "dynamo" {
  name = var.dynamodb_table_name
}

locals {
  api_path = "/api/pets"
}

module "lambda" {
  source = "git::git@github.com:terraform-aws-modules/terraform-aws-lambda.git?ref=v2.11.0"

  function_name = var.name
  description   = "Lambda function to list random pets"
  handler       = "index.handler"
  runtime       = "nodejs14.x"

  source_path = "${path.module}/src"

  vpc_subnet_ids         = var.vpc_subnet_ids
  vpc_security_group_ids = [aws_security_group.lambda.id]

  create_role              = true
  attach_network_policy    = true
  attach_policy_statements = true
  policy_statements = {
    allow_dynamodb = {
      effect    = "Allow",
      actions   = ["dynamodb:*"],
      resources = [data.aws_dynamodb_table.dynamo.arn]
    },
    allow_kms = {
      effect    = "Allow",
      actions   = ["kms:*"],
      resources = [var.kms_key_arn]
    }
  }

  environment_variables = {
    DYNAMODB_TABLE_NAME : var.dynamodb_table_name
  }

  tags = var.common_tags
}

resource "aws_lambda_permission" "alb" {
  statement_id  = "AllowExecutionFromALB"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.lambda_function_name
  principal     = "elasticloadbalancing.amazonaws.com"
  source_arn    = aws_lb_target_group.lambda.arn
}

resource "aws_lb_target_group" "lambda" {
  name        = "${var.name}-lambda"
  target_type = "lambda"
}

resource "aws_lb_target_group_attachment" "lambda" {
  target_group_arn = aws_lb_target_group.lambda.arn
  target_id        = module.lambda.lambda_function_arn
  depends_on       = [aws_lambda_permission.alb]
}

resource "aws_lb_listener_rule" "lambda" {
  listener_arn = var.alb_listener_arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lambda.arn
  }

  condition {
    path_pattern {
      values = [local.api_path]
    }
  }
}

resource "aws_security_group" "lambda" {
  name        = "${var.name}-lambda"
  description = "${var.name}-lambda-sg"
  vpc_id      = var.vpc_id

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

