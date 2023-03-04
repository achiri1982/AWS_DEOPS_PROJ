resource "aws_instance" "demo-jenkins" {
  ami           = "ami-0be8362a1f51bfe28"
  instance_type = "t2.medium"
  key_name      = "mykeypair"
  subnet_id     = "${aws_subnet.subnetB_2.id}"
  vpc_security_group_ids = [aws_security_group.demo_sg_1_2.id]
  user_data = "${file("userdata.sh")}"


  tags = {
    terraform = "true"
    Name = "demo-jenkins"
  }
}

resource "aws_eip" "demo_eip" {
    vpc = "true"
}

resource "aws_eip_association" "demo_eip_ip_ass" {
    instance_id = aws_instance.demo-jenkins.id
    allocation_id = aws_eip.demo_eip.id
}

output "elastic_ip" {
    value = aws_eip.demo_eip.public_ip
}

#TO:DO Sanji pull jenkins password upon install and send it ot stdout in TF.
#Ensure you assign