resource "aws_efs_file_system" "this" {
  creation_token   = "${var.cluster_name}-efs"
  encrypted        = var.encrypted
  performance_mode = "generalPurpose" # or "maxIO"  
  tags = {
    Name = "${var.cluster_name}-efs"
  }
}

resource "aws_efs_mount_target" "this" {
  count = length(var.private_subnets)

  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = var.private_subnets[count.index]
  security_groups = [aws_security_group.this.id]
}

resource "aws_efs_access_point" "data" {
  file_system_id = aws_efs_file_system.this.id
  posix_user {
    uid = "1000"
    gid = "1000"
  }
  root_directory {
    path = "/data"
    creation_info {
      owner_uid   = "1000"
      owner_gid   = "1000"
      permissions = "755"
    }
  }
  tags = {
    Name = "${var.cluster_name}-data-ap"
  }
}
