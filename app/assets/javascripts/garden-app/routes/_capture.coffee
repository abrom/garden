App.CaptureRoute = App.MenuRoute.extend App.Speakable,
  hideMenu: true

  setupController: (controller, model)->
    @_super controller, model
    @get('store').peekAll('camera').invoke 'unloadRecord'
    App.CameraEnumeratorService.create().enumerateCameras(@get('store')).then (cameras)->
      controller.set 'cameras', cameras

  actions:
    backClick: ->
      @transitionTo 'garden'

#    captureClick: ->
#      @speak 'boop'
#
    handleCode: (code)->
      @speak 'beep'

      return if @_redirectMatch '^p([0-9]*)$', code, 'plant'

  _redirectMatch: (regex, code, path)->
    match = new RegExp(regex).exec code.toLowerCase()
    if match
      @transitionTo path, match[1]
      true
    else
      false
