package testimpl

import (
	"context"
	"os"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azcore"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/arm"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/cloud"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	apiManagement "github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/apimanagement/armapimanagement"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"gotest.tools/v3/assert"
)

func TestApiManagementModule(t *testing.T, ctx types.TestContext) {
	subscriptionId := os.Getenv("ARM_SUBSCRIPTION_ID")
	if len(subscriptionId) == 0 {
		t.Fatal("ARM_SUBSCRIPTION_ID environment variable is not set")
	}

	credential, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		t.Fatalf("Unable to get credentials: %e\n", err)
	}

	t.Run("doesApiManagementLoggerExist", func(t *testing.T) {
		resourceGroupName := terraform.Output(t, ctx.TerratestTerraformOptions(), "resource_group_name")
		serviceName := terraform.Output(t, ctx.TerratestTerraformOptions(), "api_management_name")
		loggerName := terraform.Output(t, ctx.TerratestTerraformOptions(), "logger_name")
		loggerId := terraform.Output(t, ctx.TerratestTerraformOptions(), "logger_id")

		options := arm.ClientOptions{
			ClientOptions: azcore.ClientOptions{
				Cloud: cloud.AzurePublic,
			},
		}

		loggerClient, err := apiManagement.NewLoggerClient(subscriptionId, credential, &options)
		if err != nil {
			t.Fatalf("Error getting API Management logger client: %v", err)
		}

		logger, err := loggerClient.Get(context.Background(), resourceGroupName, serviceName, loggerName, nil)
		if err != nil {
			t.Fatalf("Error getting API Management logger: %v", err)
		}

		assert.Equal(t, loggerId, *logger.ID)
	})
}
