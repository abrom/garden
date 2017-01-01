App.CameraInputComponent = Em.Component.extend
  loadDefault: (->
    if @get 'storage.cameraId'
      @set 'currentCamera', @get('cameras').findBy('deviceId', @get('storage.cameraId'))
    else
      @set 'currentCamera', @get('cameras').find (camera)-> camera.get('label').match(/back/i) != null
  ).observes 'cameras'

  saveDefault: (->
    if @get 'currentCamera'
      @set 'storage.cameraId', @get 'currentCamera.deviceId'
  ).observes 'currentCamera'

  multipleCameras: Em.computed.gt 'cameras.length', 1

  actions:
    changeCamera: (camera)->
      @set 'currentCamera', camera

    backClick: -> @sendAction 'backClick'
    captureClick: -> @sendAction 'captureClick'
    handleCode: (code)-> @sendAction 'handleCode', code
