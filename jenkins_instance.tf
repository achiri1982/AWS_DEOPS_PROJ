resource "aws_instance" "demo-jenkins" {
  ami           = "ami-0be8362a1f51bfe28"
  instance_type = "t2.micro"
  key_name      = "mykeypair"

  user_data = ${file("userdata.sh")}


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

