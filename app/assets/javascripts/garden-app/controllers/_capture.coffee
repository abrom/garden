App.CaptureController = Em.Controller.extend
  setDefault: (->
    if @get 'storage.cameraId'
      @set 'currentCamera', @get('cameras').findBy('deviceId', @get('storage.cameraId'))
  ).observes 'cameras'

  saveDefault: (->
    if @get 'currentCamera'
      @set 'storage.cameraId', @get 'currentCamera.deviceId'
  ).observes 'currentCamera'
