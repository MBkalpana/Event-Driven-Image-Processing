variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type = list(string)
}
variable "Availability_zones" {
  description = "Availability_zones"
  type = list(string)
}
variable "private_subnet_cidrs" {
  description = "CIDR Blocks for private subnets"
  type = list(string)
}
variable "public_subnet_cidrs" {
  description = "CIDR Blocks for public subnets"
  type = list(string)
}
