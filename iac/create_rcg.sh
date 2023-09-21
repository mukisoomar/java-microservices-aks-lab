#!/bin/sh
#export UNIQUEID=$(openssl rand -hex 3)
export UNIQUEID=0849f2
export APPNAME=petclinic
export RESOURCE_GROUP=rg-$APPNAME-$UNIQUEID
export LOCATION=eastus

# Create Resource Group
az group create -g $RESOURCE_GROUP -l $LOCATION

# Create Container Registry
export MYACR=acr$APPNAME$UNIQUEID
az acr create \
    -n $MYACR \
    -g $RESOURCE_GROUP \
    --sku Basic

# Create virtual network and subnet for the AKS cluster
export VIRTUAL_NETWORK_NAME=vnet-$APPNAME-$UNIQUEID
az network vnet create \
    --resource-group $RESOURCE_GROUP \
    --name $VIRTUAL_NETWORK_NAME \
    --location $LOCATION \
    --address-prefix 10.1.0.0/16
   
export AKS_SUBNET_CIDR=10.1.0.0/24
az network vnet subnet create \
    --resource-group $RESOURCE_GROUP \
    --vnet-name $VIRTUAL_NETWORK_NAME \
    --address-prefixes $AKS_SUBNET_CIDR \
    --name aks-subnet

#export SUBNET_ID = $(az network vnet subnet show --resource-group $RESOURCE_GROUP --vnet-name $VIRTUAL_NETWORK_NAME --name aks-subnet --query id -o tsv)
#SUBNET_ID=$(az network vnet subnet show --resource-group $RESOURCE_GROUP --vnet-name $VIRTUAL_NETWORK_NAME --name aks-subnet --query id -o tsv)

export SUBNET_ID="/subscriptions/e8ae8ad0-8a4c-4ed0-96be-f7f3e19678db/resourceGroups/rg-petclinic-0849f2/providers/Microsoft.Network/virtualNetworks/vnet-petclinic-0849f2/subnets/aks-subnet"

# Create AKS cluster
# export AKS_CLUSTER_NAME=aks-$APPNAME-$UNIQUEID
# az aks create \
#     --resource-group $RESOURCE_GROUP \
#     --name $AKS_CLUSTER_NAME \
#     --node-count 1 \
#     --network-plugin azure \
#     --vnet-subnet-id $SUBNET_ID \
#     --docker-bridge-address     

AKSCLUSTER=aks-$APPNAME-$UNIQUEID

az aks create \
    -n $AKSCLUSTER \
    -g $RESOURCE_GROUP \
    --location $LOCATION \
    --generate-ssh-keys \
    --attach-acr $MYACR \
    --vnet-subnet-id $SUBNET_ID


# validating a Generated token
# curl -XGET -H 'authorization: token <token_value>' 'https://api.github.com/repos/<user_name>/spring-petclinic-microservices-config'


