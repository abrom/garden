App.Speakable = Em.Mixin.create
  speak: (text, options = {})->
    defaults =
      lang: 'en-AU'
      pitch: 1.5
      rate: 1.5
    options = $.extend defaults, options

    u = new SpeechSynthesisUtterance()
    u.text = text
    $.extend u, options
    speechSynthesis.speak u
