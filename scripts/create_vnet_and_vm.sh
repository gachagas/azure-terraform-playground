
PW="Password1234!" # use a secure password

# Virtual Networks
az network vnet create \
    --resource-group ${RG} \
    --name SalesVNet \
    --address-prefixes 10.1.0.0/16 \
    --subnet-name Apps \
    --subnet-prefixes 10.1.1.0/24 \
    --location northeurope

az network vnet create \
    --resource-group ${RG} \
    --name MarketingVNet \
    --address-prefixes 10.2.0.0/16 \
    --subnet-name Apps \
    --subnet-prefixes 10.2.1.0/24 \
    --location northeurope


az network vnet create \
    --resource-group ${RG} \
    --name ResearchVNet \
    --address-prefixes 10.3.0.0/16 \
    --subnet-name Data \
    --subnet-prefixes 10.3.1.0/24 \
    --location westeurope


# Virtual machines
az vm create \
    --resource-group ${RG} \
    --no-wait \
    --name SalesVM \
    --location northeurope \
    --vnet-name SalesVNet \
    --subnet Apps \
    --image Ubuntu2204 \
    --admin-username azureuser \
    --admin-password $PW



az vm create \
    --resource-group ${RG} \
    --no-wait \
    --name MarketingVM \
    --location northeurope \
    --vnet-name MarketingVNet \
    --subnet Apps \
    --image Ubuntu2204 \
    --admin-username azureuser \
    --admin-password $PW


az vm create \
    --resource-group ${RG} \
    --no-wait \
    --name ResearchVM \
    --location westeurope \
    --vnet-name ResearchVNet \
    --subnet Data \
    --image Ubuntu2204 \
    --admin-username azureuser \
    --admin-password $PW


# watch -d -n 5 "az vm list \
#     --resource-group ${RG} \
#     --show-details \
#     --query '[*].{Name:name, ProvisioningState:provisioningState, PowerState:powerState}' \
#     --output table"

# transform into object
# jq '.[] | {name: .name, provisioningstate:.provisioningState, powerstate:.powerState}'