# How to use environmental variables on Git bash
# To create/set the  environment variables 
export RESOURCE_GROUP_NAME='StateFileRG'
export STORAGE_ACCOUNT_NAME='statefilestorage1'
export CONTAINER_NAME='tstate'

# To see if the variable set has been set use 'echo' command
echo $RESOURCE_GROUP_NAME
echo $STORAGE_ACCOUNT_NAME
echo $CONTAINER_NAME

# In Git Bash, you should remove spaces around the equal sign when assigning values to variables. 
# Also, you can use backticks to execute a command and capture its output, do it like this:
export ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
