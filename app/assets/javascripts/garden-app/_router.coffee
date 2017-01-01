App.Router.map ->
  @resource 'garden', path: '/'
  @route 'capture'
  @resource 'plants', ->
    @route 'show', path: ':id', ->
      @route 'capture'

App.Router.reopen
  location: 'auto'
  rootURL: '/'
