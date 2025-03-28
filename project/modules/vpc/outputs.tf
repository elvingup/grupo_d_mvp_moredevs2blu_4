# Este arquivo eh responsavel por definir as saidas do modulo VPC

# Explicacao das saidas:
# - vpc_id: retorna o identificador unico da VPC criada.
# - sn_priv01: retorna o identificador da sub-rede privada sn_priv01.
# - sn_priv02: retorna o identificador da sub-rede privada sn_priv02.
# - sn_pub01: retorna o identificador da sub-rede publica sn_pub01.
# - sn_pub02: retorna o identificador da sub-rede publica sn_pub02.

output "vpc_id" {
    value = aws_vpc.elvintao_vpc.id
}
output "sn_priv01" {
    value = aws_subnet.sn_priv01.id
}
output "sn_priv02" {
    value = aws_subnet.sn_priv02.id
}
output "sn_pub01" {
    value = aws_subnet.sn_pub01.id
}
output "sn_pub02" {
    value = aws_subnet.sn_pub02.id
}