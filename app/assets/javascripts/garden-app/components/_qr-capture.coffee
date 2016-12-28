App.QrCaptureComponent = Em.Component.extend
  codeChanged: (->
    @sendAction 'codeRead', @get('qrcode')
  ).observes 'qrcode'

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
    canvas = @$('#qr-canvas')[0]
    context = canvas.getContext '2d'
    context.clearRect 0, 0, canvas.width, canvas.height
    @setProperties
      canvas: canvas
      canvasContext: context

  _captureFrame: ->
    return unless @get 'stream'

    start = performance.now()
    try
      @get('canvasContext').drawImage @$('video')[0], 0, 0
      @set 'qrcode', qrcode.decode()
    catch
    end = performance.now()

    Em.run.later @, @_captureFrame, Math.min(Math.max(end - start, 100), 500)
