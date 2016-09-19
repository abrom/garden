App.CaptureRoute = Em.Route.extend App.Speakable,
  setupController: (controller)->
    @get('store').peekAll('camera').invoke 'unloadRecord'
    App.CameraEnumeratorService.create().enumerateCameras(@get('store')).then (cameras)->
      controller.set 'cameras', cameras

  actions:
    handleCode: (code)->
      @speak 'beep'
