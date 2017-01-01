App.VideoCaptureComponent = Em.Component.extend
  qrMode: Em.computed.equal 'mode', 'qr'
  photoMode: Em.computed.equal 'mode', 'photo'

  codeChanged: (->
    @sendAction 'codeRead', @get('qrcode')
  ).observes 'qrcode'

  click: ->
    @_getImage() if @get 'photoMode'

  didInsertElement: ->
    @_setupCanvas()
    @set 'video', @$('video')[0]

  willDestroyElement: ->
    @stopStream()

  stopStream: ->
    if @get 'stream'
      @get('stream').getTracks().forEach (track) -> track.stop()
      @set 'stream', null

  changeCamera: (->
    @set 'cameraLoadError', false
    @stopStream()

    navigator.mediaDevices.getUserMedia(@get('cameraOptions')).then (stream)=>
      @set 'stream', stream
      @get('video').srcObject = stream
    .catch => @set 'cameraLoadError', true

    if @get 'qrMode'
      Em.run.later @, @_captureFrame, 500
  ).on('init').observes 'camera'

  cameraOptions: (->
    if @get 'camera.deviceId'
      video:
        deviceId:
          exact: @get 'camera.deviceId'
    else
      video: true
  ).property 'camera', 'camera.deviceId'

  _setupCanvas: ->
    canvas = @$('#video-canvas')[0]
    context = canvas.getContext '2d'
    context.clearRect 0, 0, canvas.width, canvas.height
    @setProperties
      canvas: canvas
      canvasContext: context

  _captureFrame: ->
    return unless @get 'stream'

    start = performance.now()
    try
      @_saveImage()
      @set 'qrcode', qrcode.decode @get('canvasContext')
    catch
    end = performance.now()

    Em.run.later @, @_captureFrame, Math.min(Math.max(end - start, 100), 500)

  _saveImage: ->
    @get('canvasContext').drawImage @$('video')[0], 0, 0

  _getImage: ->
    @_saveImage()
    @get('canvas').toBlob (blob)=>
      @sendAction 'captureClick', blob
    , 'image/png'
