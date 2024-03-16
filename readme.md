# do-checker-terraform

  

1. clone the repo

  

## service principal authentication and variables

    # backend initialization for the terraform.tfstate note: variables do not work in this scope

    # put your privileged service principal credentails

-  in the backend
```
terraform {
  backend "azurerm" {
    resource_group_name  = "xxxxxxxxxxxxxxxxxxxxxxxxx"
    storage_account_name = "xxxxxxxxxxxxxxxxxxxxxxxxx"
    container_name       = "xxxxxxxxxxxxxxxxxxxx"
    key                  = "prod.terraform.tfstate"
    subscription_id      = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    tenant_id            = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    client_id            = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    client_secret        = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  }
}    
```

      
  

- in  configuration environments/prod/variables.tf

```
variable "SUBSCRIPTION_ID" {
  description = "SUBSCRIPTION_ID"
  type        = string
  default     = "xxxxxxxxxxxxxxxxxxxxxx"
}

variable "CLIENT_SECRET" {
  description = "CLIENT_SECRET"
  type        = string
  default     = "xxxxxxxxxxxxxxxxxxxxx"
}

variable "CLIENT_ID" {
  description = "CLIENT_ID"
  type        = string
  default     = "xxxxxxxxxxxxxxxxxxxxxx"
}


variable "TENANT_ID" {
  description = "TENANT_ID"
  type        = string
  default     = "xxxxxxxxxxxxxxxxxxxxxxxx"
}

```

2. verify the  path of you keys folder in  *modules/compute/variables.tf*. variable's name is keys_folder and public_key_location
	- ![[Pasted image 20240315134115.png]]
  
## run

  

3. navigate to the root folder configuration /environments/prod

4. run `terraform init`

5. run `terraform apply --auto-approve`

## ssh vm


6. a private key will be generated in  /environments/prod/keys with the name 'azure_ssh_key.pem' 

	if the you did not find azure_ssh_key.pem in keys folder. that means the local-file resource does not work and you need to genrate the ssh keys manually. to do so: 
	1. generate a private and public keys in /environments/prod/keys with the name 'azure_ssh_key' 
	`ssh-keygen.exe -t rsa -b 4096 -f ./azure_ssh_key`
	![[Pasted image 20240315122402.png]]
	2. comment out this resource in the compute module main.tf
	![[Pasted image 20240315133712.png]]
	-  and in the admin_ssh_key,
		![[Pasted image 20240315133907.png]]
		 - comment out the `public_key = "${var.public_ssh_key}"`
		 - and uncomment the `public_key = file(var.public_key_location)`, to use the ssh_key you have generated
1. an output of the public ip will be shown

- if you want to ssh the vm created by the iac configuration use the private key generated ex: `ssh -i /environments/prod/keys/azure_ssh_key.pem` node-1@public_ip_of_the_vm