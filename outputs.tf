output "ec2_public_ip_1" {
  description = "The public IP address of the my_vm1 EC2 instances"
  value = aws_instance.my_vm1.public_ip
}

output "ec2_public_ip_2" {
  description = "The public IP address of the my_vm2 EC2 instances"
  value = aws_instance.my_vm2.public_ip
}

output "ec2_public_ip_3" {
  description = "The public IP address of the my_vm3 EC2 instances"
  value = aws_instance.my_vm3.public_ip
}

output "lb_dns_name" {
  value = aws_lb.front_end.dns_name
}