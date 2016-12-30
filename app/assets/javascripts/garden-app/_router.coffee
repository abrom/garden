App.Router.map ->
  @resource 'garden', path: '/'
  @resource 'capture', path: '/capture'
  @resource 'plant', path: '/plant/:id'

App.Router.reopen
  location: 'auto'
  rootURL: '/'
