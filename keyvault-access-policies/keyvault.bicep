param location string
param keyVaultName string
param accessPolicies array
param tenantId string
param createMode string = 'default'
param skuFamily string = 'A'
param skuName string = 'standard'
param existingTags object = resourceGroup().tags != null ? resourceGroup().tags : {}

var updatedTags = {
  keyVaultExists: true
}

resource keyvault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: skuFamily
      name: skuName
    }
    tenantId: tenantId
    createMode: createMode
    enabledForTemplateDeployment: true
    accessPolicies: accessPolicies
  }
}

resource tags 'Microsoft.Resources/tags@2020-10-01' = {
  name: 'default'
  properties: {
    tags: union(existingTags, updatedTags)
  }
  dependsOn: [
    keyvault
  ]
}
