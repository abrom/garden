App.Router.map ->
  @resource 'garden', path: '/'
  @resource 'capture', path: '/capture'

App.Router.reopen
  location: 'auto'
  rootURL: '/'
