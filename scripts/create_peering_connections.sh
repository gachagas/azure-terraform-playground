az network vnet peering create \
    --name SalesVNet-To-MarketingVNet \
    --remote-vnet MarketingVNet \
    --resource-group ${RG} \
    --vnet-name SalesVNet \
    --allow-vnet-access


az network vnet peering create \
    --name MarketingVNet-To-SalesVNet \
    --remote-vnet SalesVNet \
    --resource-group ${RG} \
    --vnet-name MarketingVNet \
    --allow-vnet-access


az network vnet peering create \
    --name MarketingVNet-To-ResearchVNet \
    --remote-vnet ResearchVNet \
    --resource-group ${RG} \
    --vnet-name MarketingVNet \
    --allow-vnet-access

az network vnet peering create \
    --name ResearchVNet-To-MarketingVNet \
    --remote-vnet MarketingVNet \
    --resource-group ${RG} \
    --vnet-name ResearchVNet \
    --allow-vnet-access

## Check connections
# az network vnet peering list \
#     --resource-group ${RG} \
#     --vnet-name SalesVNet \
#     --query "[].{Name:name, Resource:resourceGroup, PeeringState:peeringState, AllowVnetAccess:allowVirtualNetworkAccess}"\
#     --output table

# az network vnet peering list \
#     --resource-group ${RG} \
#     --vnet-name ResearchVNet \
#     --query "[].{Name:name, Resource:resourceGroup, PeeringState:peeringState, AllowVnetAccess:allowVirtualNetworkAccess}"\
#     --output table

# az network vnet peering list \
#     --resource-group ${RG} \
#     --vnet-name MarketingVNet \
#     --query "[].{Name:name, Resource:resourceGroup, PeeringState:peeringState, AllowVnetAccess:allowVirtualNetworkAccess}"\
#     --output table`


# route tables per vm
az network nic show-effective-route-table \
    --resource-group ${RG} \
    --name SalesVMVMNic \
    --output table

az network nic show-effective-route-table \
    --resource-group ${RG} \
    --name MarketingVMVMNic \
    --output table

az network nic show-effective-route-table \
    --resource-group ${RG} \
    --name ResearchVMVMNic \
    --output table