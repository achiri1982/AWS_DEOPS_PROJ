resource "aws_lb" "demo-lb-2" {
  name               = "demo-lb-2"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.demo_sg_1_2.id]
  subnets            = [aws_subnet.subnetA_2.id, aws_subnet.subnetB_2.id]

  tags = {
    environment = var.environment["prod"]
  }
}

resource "aws_lb_target_group" "demo_tg_2" {
  name     = "lb-demo-tg-2"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.demo-vpc-2.id
}

resource "aws_autoscaling_attachment" "demo_asg_attachment_2" {
  autoscaling_group_name = aws_autoscaling_group.demo_asg_2.id
  lb_target_group_arn    = aws_lb_target_group.demo_tg_2.arn
}

resource "aws_lb_listener" "demo-list-2" {
  load_balancer_arn = aws_lb.demo-lb-2.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demo_tg_2.arn
  }
}