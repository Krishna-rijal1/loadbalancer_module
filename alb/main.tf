//create load balancer
resource "aws_alb" "load_balancer" {
  name               = "load-balancer-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group]
  subnets            = [var.subnet1, var.subnet2]

    enable_deletion_protection = false

}
//create target group
resource "aws_lb_target_group" "target_group" {
  name        = "test-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
  health_check {
    enabled             = true
    healthy_threshold   = 5
    unhealthy_threshold = 5
    timeout             = 120
    interval            = 300
    matcher             = 200
    path                = "/"
  }
  lifecycle {
    create_before_destroy = true
  }
}

//create target group attachement
resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.instance_id1
  port             = 80
}
resource "aws_lb_target_group_attachment" "test-ii" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.instance_id2
  port             = 80
}

//create listener
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_alb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}



