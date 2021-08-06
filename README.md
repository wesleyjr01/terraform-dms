# terraform-tutorial
Terraform Official Tutorial


### Create Resources
* Resource blocks have two strings before the block, the resource type and resource name. The prefix of the type maps to the name of the provider, in this case, AWS. Together, the resource type and resource name form a unique ID for the resource. This id can be used to refer to this resource in other parts of configuration.
* Whenever you create a new configuration, you need to initialize your working directory with `terraform init`. Include `.terraform.lock.hcl` file in your version control repository
so that Terraform can guarantee to make the same selections by default when making changes.
* Now do `terraform apply` to deploy the changes.
* When you applied your configuration, Terraform wrote data into a file called `terraform.tfstate`. Terraform stores the IDs and properties of the resources it manages in this file, so that it can update or destroy those resources going forward.
* The Terraform state file is the only way Terraform can track which resources it manages, and often contains sensitive information, so you must store your state file securely and restrict access to only trusted team members who need to manage your infrastructure. In production, we recommend storing your state remotely with Terraform Cloud or Terraform Enterprise. Terraform also supports several other remote backends you can use to store and manage your state.
you run `terraform init` in the future.
* List resources in your project: `terraform state list`
* Inspect the current state using `terraform show`

### Applying Changes
* After making changes in `main.tf`, run `terraform apply`.

### Destroying Resources
* `terraform destroy`


### Define Input Variables
* You dont need to use hardcoded values.
* Terraform can use variables to make your configurations more dynamic and flexible.
* You can define input variables to make your configuration more flexible and reusable.
* Create a file `variables.tf`
* Change the varible name when calling terraform apply: `terraform apply -var 'instance_name=YetAnotherVariableName'`

### Query Data with Outputs
* In this tutorial, you will use output values to organize data to be easily queried and displayed to the Terraform user.
* Create a file names `outputs.tf`.
* After editing `outputs.tf`, apply changes: `terraform apply`
* You can now query outputs with `terraform output`