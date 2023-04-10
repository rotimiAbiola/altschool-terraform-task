variable "region" {
  description = "Region where infrastructure was created"
  type = string
  default = "eu-central-1"
}

variable "access_key" {
  sensitive = true
  description = "access key for the IAM user"
  type = string 
}

variable "secret_key" {
  sensitive = true
  description = "secret key for the IAM user"
  type = string 
}


variable "vpc_cidr_block" {
  description = "CIDR Block for the VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "web1_cidr_block" {
  description = "CIDR Block for web1 subnet"
  type = string
  default = "10.0.10.0/24"
}

variable "web2_cidr_block" {
  description = "CIDR Block for web2 subnet"
  type = string
  default = "10.0.20.0/24"
}

variable "web3_cidr_block" {
  description = "CIDR Block for web3 subnet"
  type = string
  default = "10.0.30.0/24"
}

variable "azs" {
  description = "List of availability zones in the region"  
  type = list(string)
  default = [ 
    "eu-central-1a", 
    "eu-central-1b", 
    "eu-central-1c" 
    ]
}

variable "ingress_ports" {
  description = "List of ingress Ports"
  type = list(number)
  default = [ 22, 80 ]
}

variable "ssh_public_key" {
}

// Route 53 Variables
variable "domain_name" {
  default = "abiolarotimi.me"
  description = "domain name"
  type = string
}

variable "record_name" {
  default = "terraform-test"
  description = "sub domain name"
  type = string
}
