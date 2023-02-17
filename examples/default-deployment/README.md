# Default Deployment Example
This folder contains an example deployment for the module in this repository. See the below instructions for running the example for testing purposes; either manually or using [Terratest]().

## Manual testing
1. Install [Terraform]()
2. Run `terraform init`
3. Run `terraform apply`
4. Confirm the deployment is succesful and configured as expected
5. Run `terraform destroy`

## Automated testing
1. Install [Terraform]()
2. Install [Go]()
3. Run `cd test`
4. Run `dep ensure`
5. Run `go test -v -run TestModuleDeployment`
