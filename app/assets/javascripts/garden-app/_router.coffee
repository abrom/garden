App.Router.map ->
  @resource 'garden', path: '/'

App.Router.reopen
  location: 'auto'
  rootURL: '/'
