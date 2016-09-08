App.CaptureRoute = Em.Route.extend
  setupController: (controller)->
    App.CameraEnumeratorService.create().enumerateCameras(@get('store')).then (cameras)->
      controller.set 'cameras', cameras
