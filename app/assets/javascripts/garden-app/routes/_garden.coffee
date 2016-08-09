App.GardenRoute = Em.Route.extend
  setupController: ->
    App.CameraEnumeratorService.create().enumerateCameras @get('store')
