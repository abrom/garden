App.CaptureRoute = Em.Route.extend App.Speakable,
  setupController: (controller)->
    @get('store').peekAll('camera').invoke 'unloadRecord'
    App.CameraEnumeratorService.create().enumerateCameras(@get('store')).then (cameras)->
      controller.set 'cameras', cameras

  actions:
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
