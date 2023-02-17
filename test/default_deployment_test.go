package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestModuleDeployment(t *testing.T) {
	t.Parallel()

	// Define expected outputs
	expectedDataLakeAccountNamePrefix := "sttestuks"
	expectedDataLakeResourceGroupName := "rg-terratest"

	// Set deployment options
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraformOptions{
		// Define example deployment path
		TerraformDir: "../examples/default-deployment",

		// Define variables to pass to Terraform using -var options
		Vars: map[string]interface{}{
			"location": "uksouth"
			"resource_group_name": expectedDataLakeResourceGroupName,
			"resource_suffix": "test-uks"
		},

		// Define a tfvars file to pass to Terraform using the -var-file option
		// VarFiles: []string{"variables.tfvars"},

		// Disable colourised Terraform output
		NoColor: true,
	})

	// Destroy resources after testing is complete
	defer terraform.Destroy(t, terraformOptions)

	// Initialise and apply the example deployment
	terraform.InitAndApply(t, terraformOptions)

	// Get deployment outputs
	actualDataLakeAccountNamePrefix := terraform.Output(t, terraformOptions, "data_lake_account_name")
	actualDataLakeResourceGroupName := terraform.Output(t, terraformOptions, "data_lake_resource_group_name")

	// Verify output values are as expected
	assert.Contains(t, actualDataLakeAccountNamePrefix, expectedDataLakeAccountNamePrefix)
	assert.Equal(t, expectedDataLakeResourceGroupName, actualDataLakeResourceGroupName)
}
