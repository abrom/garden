App.QrCaptureComponent = Em.Component.extend
  type: 'unsupported'

  generic: Em.computed.equal 'type', 'generic'
  webkit: Em.computed.equal 'type', 'webkit'
  mozilla: Em.computed.equal 'type', 'mozilla'
  unsupported: Em.computed.equal 'type', 'unsupported'

  boop: (->
    @_speak 'beep'
  ).observes 'qrcode'

  willInsertElement: ->
    @_setupCanvas()
    @set 'video', @$('video')[0]

  changeCamera: (->
    console.log 'cc here.'
    @set 'cameraLoadError', false

    if @get 'stream'
      @get('stream').getTracks().forEach (track) -> track.stop()

    if navigator.getUserMedia
      @set 'type', 'generic'
      mediaFunction = navigator.getUserMedia
    else if navigator.webkitGetUserMedia
      @set 'type', 'webkit'
      mediaFunction = navigator.webkitGetUserMedia
    else if navigator.mozGetUserMedia
      @set 'type', 'mozilla'
      mediaFunction = navigator.mozGetUserMedia
    else
      return

    console.log @get 'camera.deviceId'

    navigator.webkitGetUserMedia
      video: @get 'cameraOptions'
      audio: false
    , (stream) =>
      @set 'stream', stream

      if @get 'webkit'
        @get('video').srcObject = stream
#        window.URL.createObjectURL(stream)
      else if @get 'mozilla'
        @get('video').mozSrcObject = stream
        @$('video')[0].play()
      else
        @get('video').src = stream
    , =>
      @set 'cameraLoadError', true

    Em.run.later @, @_captureFrame, 500
  ).on('init').observes 'camera'

  cameraOptions: (->
    if @get 'camera.deviceId'
      console.log 'here.. with d = ' + @get 'camera.deviceId'
      { deviceId: { exact: @get 'camera.deviceId' } }
    else
      console.log 'plain'
      true
  ).property 'camera', 'camera.deviceId'

  _setupCanvas: ->
    canvas = @$('#qr-canvas')[0]
    context = canvas.getContext '2d'
    context.clearRect 0, 0, canvas.width, canvas.height
    @setProperties
      canvas: canvas
      canvasContext: context

  _captureFrame: ->
    return unless @get 'videoSource'

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
