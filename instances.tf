# Associate SSH Key pair
resource "aws_key_pair" "test_ssh_key" {
  key_name = "alt_ssh_key"
  public_key = file(var.ssh_public_key)
}

# Set AMI data for latest ubuntu image
data "aws_ami" "latest_ubuntu_image"{
	owners = ["amazon"] #099720109477
	most_recent = true
	filter {
		name = "name"
		values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20221201"]
	}
	filter {
		name = "virtualization-type"
		values = ["hvm"]
	}
	filter {
	  name = "architecture"
	  values = ["x86_64"]
	}

}

# Create VM in subnet1
resource "aws_instance" "my_vm1" {
	ami = data.aws_ami.latest_ubuntu_image.id
	instance_type = "t2.micro"
	subnet_id = aws_subnet.web1.id
	vpc_security_group_ids = [aws_default_security_group.alt_vpc_default_sg.id]
	associate_public_ip_address = true
	key_name = aws_key_pair.test_ssh_key.key_name
	tags = {
		"Name" = "Alt VM1"
	}  
}

# Create VM in subnet2
resource "aws_instance" "my_vm2" {
	ami = data.aws_ami.latest_ubuntu_image.id
	instance_type = "t2.micro"
	subnet_id = aws_subnet.web2.id
	vpc_security_group_ids = [aws_default_security_group.alt_vpc_default_sg.id]
	associate_public_ip_address = true
	key_name = aws_key_pair.test_ssh_key.key_name
	tags = {
		"Name" = "Alt VM2"
	}  
}

# Create VM in subnet3
resource "aws_instance" "my_vm3" {
	ami = data.aws_ami.latest_ubuntu_image.id
	instance_type = "t2.micro"
	subnet_id = aws_subnet.web3.id
	vpc_security_group_ids = [aws_default_security_group.alt_vpc_default_sg.id]
	associate_public_ip_address = true
	key_name = aws_key_pair.test_ssh_key.key_name
	tags = {
		"Name" = "Alt VM3"
	}  
}

// Redirect IPs to host file
resource "local_file" "ec2_public_ip" {
    content  = <<EOF
[webservers]
${aws_instance.my_vm1.public_ip}
${aws_instance.my_vm2.public_ip}
${aws_instance.my_vm3.public_ip}
EOF
    filename = "./playbook/host-inventory"
}
