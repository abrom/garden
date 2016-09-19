App.initializer
  name: 'Inject Storage',
  initialize: (registry, application)->
    application.register 'service:storage', App.Storage
    application.inject 'route', 'storage', 'service:storage'
    application.inject 'component', 'storage', 'service:storage'
    application.inject 'controller', 'storage', 'service:storage'
