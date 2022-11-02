param name string

resource apim 'Microsoft.ApiManagement/service@2021-08-01' existing = {
  name: 'apim-${name}'
}

resource swapi 'Microsoft.ApiManagement/service/apis@2021-08-01' = {
  parent: apim
  name: 'swapi'
  properties:{
    format: 'openapi+json-link'
    value: 'https://stg${name}hack.blob.core.windows.net/swapi/swapi-swagger.json'
    displayName: 'Starwars API'
    path: 'ch3'
    protocols:[
      'https'
    ]
    apiType:'http'
  }
}

resource subscription 'Microsoft.ApiManagement/service/subscriptions@2021-12-01-preview' = {
  name: 'swapi-sub'
  parent: apim
  properties: {
    scope: '/apis/swapi'
    displayName: 'swapi-sub'
    allowTracing: true
  }
  dependsOn: [
    swapi
  ]
}
