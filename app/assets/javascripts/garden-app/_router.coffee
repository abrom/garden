App.Router.map ->
  @resource 'garden', path: '/'
  @route 'capture'
  @resource 'plants', path: '/plants/:id', ->
    @route 'capture'

App.Router.reopen
  location: 'auto'
  rootURL: '/'
