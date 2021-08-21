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

### Notes about DMS
* Activate `binlog` on source Postgres db before appling CDC on DMS Replication Instance:
  * Create a new `Parameter Group`. On this new `Parameter Group`, change the parameter `rds.logical_replication` from 0 to 1. The other parameter to change is `wal_sender_timeout`, set it to 0. Then, set this newly created Parameter Group to the RDS instance.
* We must configure our Replication Instance in such a way that the Change Captures are not too small (dumping too many small files into the Data Lake buckets). We need to figure our the correct parameters to dump correct size batches on our change data captures (files around a few hundred megabytes each is good, not kilobytes).
* [Read this link about VPC peering](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_ReplicationInstance.PublicPrivate.html), were we can connect two different VPCs as they were one. This can be very usefull for migrating tasks that need to reach two different VPCs.
* A `subnet group` is a collection of subnets (typically private) that you can designate for your clusters running in an Amazon Virtual Private Cloud (VPC) environment. When creating a `Replication Instance`, you must specify a `aws_dms_replication_subnet_group`. On `aws_dms_replication_subnet_group`, you must specify `subnet_ids`.
* An `AWS security group` acts as a virtual firewall for your EC2 instances to control incoming and outgoing traffic. Both inbound and outbound rules control the flow of traffic to and traffic from your instance, respectively. You will have to define `vpc_security_group_ids` in your `aws_dms_replication_instance`.