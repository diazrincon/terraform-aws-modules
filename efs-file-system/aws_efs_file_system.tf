resource "aws_efs_file_system" "this" {
  creation_token   = var.efs_name
  encrypted        = var.encrypted
  performance_mode = "generalPurpose" # or "maxIO"  
  tags = {
    Name = var.efs_name
  }
}

resource "aws_efs_mount_target" "this" {
  for_each = toset(data.aws_subnets.private.ids)

  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = each.value
  security_groups = var.security_groups
}
