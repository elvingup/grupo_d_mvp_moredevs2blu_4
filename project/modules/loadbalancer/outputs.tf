# Este arquivo eh responsavel por definir as saidas do modulo loadbalancer

# Explicacao das saidas:
# - ami_loadbalancer_id: retorna o identificador unico da imagem utilizada pelo loadbalancer.
# - ami_loadbalancer_shape: retorna o tipo de instancia utilizada pelo loadbalancer.
# - ami_loadbalancer_network_interface_id: retorna o identificador da interface de rede utilizada pelo loadbalancer.

output "ami_loadbalancer_id" {
    value = aws_instance.elvintao_nginx_ec2.ami
}

output "ami_loadbalancer_shape" {
    value = aws_instance.elvintao_nginx_ec2.instance_type
}

output "ami_loadbalancer_network_interface_id" {
    value = aws_instance.elvintao_nginx_ec2.subnet_id
}

output "sg_loadbalancer_id" {
    value = security_group_id
}

output "loadbalancer_cidr_block" {
    value = aws_instance.elvintao_nginx_ec2.cidr_ipv4
}