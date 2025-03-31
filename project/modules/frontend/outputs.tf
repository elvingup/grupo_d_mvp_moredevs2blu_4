output "frontend_instance_id" {
    value = aws_instance.elvintao_frontend_vm.id
}

output "frontend_private_ip" {
    value = aws_instance.elvintao_frontend_vm.private_ip
}