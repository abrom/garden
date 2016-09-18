App.CaptureRoute = Em.Route.extend App.Speakable,
  setupController: (controller)->
    App.CameraEnumeratorService.create().enumerateCameras(@get('store')).then (cameras)->
      controller.set 'cameras', cameras

  actions:
    handleCode: (code)->
      @speak 'beep'
