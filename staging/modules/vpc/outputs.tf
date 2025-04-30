output "vpc_id" {
    value = aws_vpc.my_vpc.id
}

output "subnet_ids" {
    value    = [
    aws_subnet.public-webtier-subnet-1.id,
    aws_subnet.public-webtier-subnet-2.id
  ]
}