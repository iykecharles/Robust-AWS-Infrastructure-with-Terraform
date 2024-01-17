variable "az" {
    description = "availability zones"
    type = list
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "subnets" {
    description = "public and private subnet"
    type = list
    default = ["public-Web-Subnet-az1", "public-Web-Subnet-az2", "public-Web-Subnet-az3", "private-App-Subnet-az1", "private-App-Subnet-az2", "private-App-Subnet-az3", "private-Db-Subnet-az1", "private-Db-Subnet-az2", "private-Db-Subnet-az3"]
}

variable "cidr" {
    description = "Classless Inter-Domain Routing"
    type = list
    default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24"]
}


