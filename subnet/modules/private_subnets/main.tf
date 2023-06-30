variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "private_subnet_count" {
  description = "Number of private subnets to create"
  type        = number
}

variable "subnet_cidr_blocks" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "private_subnets" {
  count             = var.private_subnet_count
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidr_blocks[count.index]
  availability_zone = "us-west-2a"
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}
