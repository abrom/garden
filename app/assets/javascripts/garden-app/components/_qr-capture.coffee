App.QrCaptureComponent = Em.Component.extend
  boop: (->
    @_speak 'beep'
  ).observes 'qrcode'

  willInsertElement: ->
    @_setupCanvas()
    @set 'video', @$('video')[0]

  willDestroyElement: ->
    @stopStream()

  stopStream: ->
    if @get 'stream'
      @get('stream').getTracks().forEach (track) -> track.stop()

  changeCamera: (->
    console.log 'cc here.'
    @set 'cameraLoadError', false

    @stopStream()

    console.log @get 'camera.deviceId'

    navigator.mediaDevices.getUserMedia(@get('cameraOptions')).then (stream)=>
      @set 'stream', stream
      @get('video').srcObject = stream
    .catch => @set 'cameraLoadError', true

    Em.run.later @, @_captureFrame, 500
  ).on('init').observes 'camera'

  cameraOptions: (->
    if @get 'camera.deviceId'
      console.log 'here.. with d = ' + @get 'camera.deviceId'
      { video: { deviceId: { exact: @get 'camera.deviceId' } } }
    else
      console.log 'plain'
      { video: true }
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

    try
      @get('canvasContext').drawImage @$('video')[0], 0, 0
      @set 'qrcode', qrcode.decode()
    catch

    Em.run.later @, @_captureFrame, 500

  _speak: (text)->
    u = new SpeechSynthesisUtterance()
    u.text = text
    u.lang = 'en-AU'
    u.pitch = 1.5
    u.rate = 1.5

    speechSynthesis.speak u
