output "external_lb_sg1" {
  value = aws_security_group.external_lb1.id
}

output "external_lb_sg2" {
  value = aws_security_group.external_lb2.id
}

output "external_lb_sg3" {
  value = aws_security_group.external_lb3.id
}

output "internal_lb_sg" {
  value = aws_security_group.internal_lb.id
}

output "tasks_sg" {
  value = aws_security_group.tasks.id
}

output "efs_sg" {
  value = aws_security_group.efs.id
}
