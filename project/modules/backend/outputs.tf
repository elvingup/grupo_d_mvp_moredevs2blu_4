output "backend_instance_id" {
    value = aws_instance.elvintao_backend_vm.id
}

output "backend_private_ip" {
    value = aws_instance.elvintao_backend_vm.private_ip
}