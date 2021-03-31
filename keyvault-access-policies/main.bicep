param location string
param keyVaultName string
param servicePrincipalObjectId string
param tenantId string = subscription().tenantId

var defaultAccessPolicies = [
  {
    tenantId: tenantId
    objectId: servicePrincipalObjectId
    permissions: {
      keys: [
        'get'
        'list'
        'update'
        'create'
        'import'
        'delete'
        'recover'
        'backup'
        'restore'
      ]
      secrets: [
        'get'
        'list'
        'set'
        'delete'
        'recover'
        'backup'
        'restore'
      ]
      certificates: [
        'get'
        'list'
        'update'
        'create'
        'import'
        'delete'
        'recover'
        'backup'
        'restore'
        'managecontacts'
        'manageissuers'
        'getissuers'
        'listissuers'
        'setissuers'
        'deleteissuers'
      ]
    }
  }
]
var defaultTags = {
  keyVaultExists: false
}
var existingTags = resourceGroup().tags != null ? resourceGroup().tags : {}
var keyVaultExists = bool(union(defaultTags, existingTags)['keyVaultExists'])
var accessPolicies = keyVaultExists ? reference(resourceId('Microsoft.KeyVault/vaults', keyVaultName), '2019-09-01').accessPolicies : defaultAccessPolicies

module kv './keyvault.bicep' = {
  name: 'kvDeploy'
  params: {
    location: location
    keyVaultName: keyVaultName
    accessPolicies: accessPolicies
    tenantId: tenantId
    existingTags: existingTags
  }
}
