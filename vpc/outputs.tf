output "vpc_id" {
  value = aws_vpc.this.id
}

output "private_subnets" {
  value = merge({
    ids = [for s in aws_subnet.private : s.id]
    }, { for idx, s in aws_subnet.private : idx => {
      id   = s.id
      zone = s.availability_zone
    }
  })
}

output "public_subnets" {
  value = merge({
    ids = [for s in aws_subnet.public : s.id] },
    { for idx, s in aws_subnet.public : idx => {
      id   = s.id
      zone = s.availability_zone
      }
  })
}
