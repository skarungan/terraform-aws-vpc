# terraform-aws-vpc
Terraform VPC Module to create one Public and one Private Subnet on each of the availability zones

The module can be use like below
#For Terraform 0.8.x 
```
module "aws_vpc" {
  source = "git::https://github.com/shanmugakarna/terraform-aws-vpc.git?ref=tf-0.8.x"
  profile = "test-aws-profile"
  region = "us-east-1"
  vpc_cidr = "10.10.0.0/16"
  vpc_tag = "terraform-vpc-test"
}
```
#For Terraform 0.9.x
```
module "aws_vpc" {
  source = "git::https://github.com/shanmugakarna/terraform-aws-vpc.git"
  profile = "test-aws-profile"
  region = "us-east-1"
  vpc_cidr = "10.10.0.0/16"
  vpc_tag = "terraform-vpc-test"
}
```

It depends on aws profile and requires awscli to be installed and configured.

#Creating VPCs in two different Accounts.
Please Note: This is not recommended if you are not managing both the accounts in the same state file.
```
module "aws_vpc_1" {
  source = "git::https://github.com/shanmugakarna/terraform-aws-vpc.git?ref=tf-0.8.x"
  profile = "test-aws-profile-1"
  region = "us-east-1"
  vpc_cidr = "10.10.0.0/16"
  vpc_tag = "terraform-vpc-test-1"
}
module "aws_vpc_2" {
  source = "git::https://github.com/shanmugakarna/terraform-aws-vpc.git?ref=tf-0.8.x"
  profile = "test-aws-profile2-1"
  region = "us-east-1"
  vpc_cidr = "10.20.0.0/16"
  vpc_tag = "terraform-vpc-test-2"
}

#Add peering resources here
```
