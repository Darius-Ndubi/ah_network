# Setting up a network.

This project sets up a network to deploy the [Authors Haven](https://authors-haven-ct-staging.herokuapp.com/) on AWS.

The Amazon Machine Images can be built with help of [AMI building repo](https://github.com/Darius-Ndubi/config_and_chain_management_packer_ansible), follow steps on the readme to build the neccessary images.

## Getting Started

Clone the [repository](https://github.com/Darius-Ndubi/ah_network) and cd into `ah_network`. Initialize `terraform` with the command `terraform init` which initializes the current working directory containing the terraform configuration files. After the command has executes successfully you need to edit `sample.terraform.tfvars` by adding the aws credential files namely `aws_access_key` and `aws_secret_key`. You will also have to add the path  to a key you have downloaded from aws and add it to the variable `key_path` with the key name added to variable `aws_key_name`.

The other variables needed include `aws_front_ami`, `aws_docu_ami` and  `aws_db_ami` Which you will obtain after bulding the respective images from the [AMI building repo](https://github.com/Darius-Ndubi/)  repo.

After that you change the name of the file from `sample.terraform.tfvars` to `terraform.tfvars`. With this done you are all set to spin up the instances on aws.



### Prerequisites
Kindly install terraform on your computer.
- [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)



## Deployment

After setting up everything as per the setup stage  deployment to aws is all that is left. To deploy the configuration to aws run the command ` terraform plan` and this will output a list of resources the script will deploy to aws. When you have read through and are about the resources that are going to be created use the command `terraform apply` to startup the process. After some while you will receive a prompt on the terminal to ask if you accept the resources to be created. You should accept with a `yes` but if you feel there is something you need to change type `no`. If you accept, the resources will be built onto aws.

## Built With

* [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) - Tool that allows you to configure infrastructure as code.


## Authors
 - [Darius Ndubi](https://github.com/Darius-Ndubi)
