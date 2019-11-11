# Playground repo to learn how to manage aws with terraform and ansible

### Prerequisite package to run terraform   
* awscli installed
* terraform installed
* awscli configured with secret keys
* ssh public key should be imported to aws, variable refer as  `ssh_key_pair_name` in vars.tf file
``` bash
aws configure
```
* first you should init terraform repo
```bash
terraform init
``` 

* to apply terraform configuration 
```bash
terraform apply
``` 

