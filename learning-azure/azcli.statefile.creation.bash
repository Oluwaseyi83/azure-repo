# logon to your azure tenant
az login

# if you have multiple subscriptions then select the one you want to use
az account set -s "MPN - John Lunn"

# create environment variables to initialise a shared back end (azure storage account)
export RESOURCE_GROUP_NAME='StateFileRG'
export STORAGE_ACCOUNT_NAME='statefilestorage01'
export CONTAINER_NAME='tstate'


# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location 'eastus'

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Get storage account key
export ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY






