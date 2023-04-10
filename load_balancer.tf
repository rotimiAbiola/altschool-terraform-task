# Attach VMs to a Load Balancer

// Create a Load Balancer
resource "aws_lb" "front_end" {
  name               = "alt-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = [aws_subnet.web1.id, aws_subnet.web2.id, aws_subnet.web3.id]

  enable_deletion_protection = false

  # access_logs {
  # bucket  = aws_s3_bucket.lb_logs.bucket
  # prefix  = "test-lb"
  # enabled = true
  # }

  tags = {
    Environment = "Production"
  }
}

// Create a target group 
resource "aws_lb_target_group" "front_end" {
  name     = "application-front"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.alt_vpc.id
  health_check {
    enabled = true
    healthy_threshold = 3
    interval = 10
    matcher = 200
    path = "/"
    port = "traffic-port"
    protocol = "HTTP"
    timeout = 3
    unhealthy_threshold = 2
  }
}

// Create a LB listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}

resource "aws_lb_target_group_attachment" "attach_server1" {
  target_group_arn = aws_lb_target_group.front_end.arn
  target_id        = aws_instance.my_vm1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach_server2" {
  target_group_arn = aws_lb_target_group.front_end.arn
  target_id        = aws_instance.my_vm2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach_server3" {
  target_group_arn = aws_lb_target_group.front_end.arn
  target_id        = aws_instance.my_vm3.id
  port             = 80
}
