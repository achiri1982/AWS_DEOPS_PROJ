
resource "aws_launch_template" "demo_launch_tpl_2" {
  name_prefix            = "${var.name}-_launch_tpl"
  image_id               = "ami-0be8362a1f51bfe28"
  instance_type          = var.instance_type["development"]
  vpc_security_group_ids = [aws_security_group.demo_sg_1_2.id]
}

resource "aws_autoscaling_group" "demo_asg_2" {
  desired_capacity    = var.capacity["desired"]
  max_size            = var.capacity["max"]
  min_size            = var.capacity["min"]
  vpc_zone_identifier = [aws_subnet.subnetA_2.id, aws_subnet.subnetB_2.id]

  launch_template {
    id      = aws_launch_template.demo_launch_tpl_2.id
    version = "$Latest"
  }

}
