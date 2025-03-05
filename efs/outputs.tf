output "fs_id" {
  value = aws_efs_file_system.this.id
}

output "data_ap_id" {
  value = aws_efs_access_point.data.id
}
