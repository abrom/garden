App.initializer
  name: 'Inject Store',
  initialize: (registry, application)->
    application.set 'store', registry.container().lookup('service:store')
