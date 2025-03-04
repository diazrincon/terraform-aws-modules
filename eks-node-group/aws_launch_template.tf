resource "aws_launch_template" "this" {
  name                   = var.base_name
  image_id               = data.aws_ami.eksal2023.image_id
  vpc_security_group_ids = var.node_sgs
  user_data = base64encode(templatefile("${path.module}/workers-userdata.sh", {
    cluster_ca        = var.cluster_ca
    cluster_endpoint  = var.cluster_endpoint
    cluster_full_name = var.cluster_name
    service_ipv4_cidr = var.service_ipv4_cidr
  }))

  update_default_version = var.update_default_version

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_type           = "gp3"
      iops                  = 3000
      volume_size           = var.storage_size
      delete_on_termination = true
    }
  }

  monitoring {
    enabled = true
  }

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"
    tags          = var.tags
  }

  tag_specifications {
    resource_type = "volume"
    tags          = var.tags
  }

  tag_specifications {
    resource_type = "network-interface"
    tags          = var.tags
  }
}
