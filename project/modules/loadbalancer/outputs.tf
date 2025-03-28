output "ami_loadbalancer_id" {
    value = aws_instance.elvintao_nginx_ec2.ami
}

output "ami_loadbalancer_shape" {
    value = aws_instance.elvintao_nginx_ec2.instance_type
}

output "ami_loadbalancer_network_interface_id" {
    value = aws_instance.elvintao_nginx_ec2.subnet_id
}