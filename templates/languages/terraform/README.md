# {{ PROJECT_NAME }}

Terraform project

## Project Structure

The basic project structure is based on [best-practice](https://xebia.com/blog/four-tips-to-better-structure-terraform-projects/). It consists of the following files:

1. main.tf: contains all providers, resources and data sources
1. variables.tf: contains all defined variables
1. output.tf: contains all output resources
1. provider.tf: contains the terraform block and provider block
1. data.tf: contains all data sources
1. variables.tf: contains all defined variables
1. locals.tf: contains all local variables

Additionally there will be 2 more files:
1. terraform.tfvars: contains fix values for variables
1. backend.tf: contains backend configuration

Additionally you should create a file name per component, such as database.tf and permissions.tf. These names are more descriptive than main.tf and immediately tell what kind of resources are expected there.