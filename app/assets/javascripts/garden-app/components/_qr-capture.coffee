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
    @set 'cameraLoadError', false

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

    mediaFunction.call navigator,
      video: @get 'cameraOptions'
      audio: false
    , (stream) =>
      if @get 'webkit'
        @set 'videoSource', window.URL.createObjectURL(stream)
      else if @get 'mozilla'
        @set 'videoSource', stream
        @$('video').play()
      else
        @set 'videoSource', stream
    , =>
      @set 'cameraLoadError', true

    Em.run.later @, @_captureFrame, 500

  cameraOptions: (->
    if @get 'camera.deviceId'
      { deviceId: { exact: @get 'camera.deviceId' } }
    else
      true
  ).property 'camera.deviceId'

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
