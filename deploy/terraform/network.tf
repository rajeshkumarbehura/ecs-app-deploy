# When you have existing vpc, based on ur avaialbility zone
# update this file.
# Find out - VPC name
# Find out your public subnet name
# Find out your availbitliy zones and replace here

# network.tf without elp
variable "existing_vpc_name" {
  description = "Existing VPC in your aws cloud"
  default     = "dev-data-stream-vpc"
}

variable "existing_vpc_public_subnet_name" {
  description = "public subnet name which tie up with existing vpc"
  default     = "dev-data-stream-public-subnet"
}

data "aws_vpc" "main" {
  filter {
    name = "tag:Name"
    values = [var.existing_vpc_name]
  }
}

data "aws_subnet" "public_1a" {
  filter {
    name = "tag:Name"
    values = [var.existing_vpc_public_subnet_name]
  }

  filter {
    name = "availability-zone"
    values = ["ap-southeast-1a"]  # check zone
  }
}

data "aws_subnet" "public_1b" {
  filter {
    name = "tag:Name"
    values = [var.existing_vpc_public_subnet_name]
  }

  filter {
    name = "availability-zone"
    values = ["ap-southeast-1b"]   # check zone or replace
  }
}


data "aws_subnet" "public_1c" {
  filter {
    name = "tag:Name"
    values = [var.existing_vpc_public_subnet_name]
  }

  filter {
    name = "availability-zone"
    values = ["ap-southeast-1c"] # check zone
  }
}

# print vpc and subnet ids
output "aws_vpc_name" {
  value = data.aws_vpc.main.id
}

output "aws_subnet_1a" {
  value =  data.aws_subnet.public_1a.id
}

output "aws_subnet_1b" {
  value = data.aws_subnet.public_1b.id
}

output "aws_subnet_1c" {
  value = data.aws_subnet.public_1c.id
}
