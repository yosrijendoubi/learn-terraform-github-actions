package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/stretchr/testify/assert"
)

func TestTerrafromVerifyBackend(t *testing.T) {
	t.Parallel()

	// subscriptionID is overridden by the environment variable "ARM_SUBSCRIPTION_ID"
	subscriptionID := ""

	// website::tag::3:: Run `terraform output` to get the values of output variables
	resourceGroupName := "iotStorageYosri"
	storageAccountName := "storagewas"
	storageBlobContainerName := "edge"

	// website::tag::4:: Verify storage account properties and ensure it matches the output.

	// Verify the resource group exists
	exists := azure.ResourceGroupExists(t, resourceGroupName, subscriptionID)
	assert.True(t, exists, "Resource group does not exist")
	storageAccountExists := azure.StorageAccountExists(t, storageAccountName, resourceGroupName, subscriptionID)
	assert.True(t, storageAccountExists, "storage account does not exist")

	containerExists := azure.StorageBlobContainerExists(t, storageBlobContainerName, storageAccountName, resourceGroupName, subscriptionID)
	assert.True(t, containerExists, "storage container does not exist")
}
