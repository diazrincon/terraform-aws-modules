output "cluster_sg" {
  value = aws_security_group.cluster_sg.id
}

output "node_sg" {
  value = aws_security_group.node_sg.id
}

output "alb_ext_mabl_sg" {
  value = aws_security_group.alb_ext_mabl_sg.id
}
