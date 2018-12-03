App.Router.map ->
  @resource 'garden', path: '/'
  @route 'capture'
  @resource 'plants', ->
    @route 'show', path: ':id', ->
      @route 'capture'
  @resource 'species', ->
    @route 'new'
    @route 'show', path: ':id', ->
      @route 'new_plant'

App.Router.reopen
  location: 'auto'
  rootURL: '/'
