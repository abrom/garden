App.CaptureRoute = App.MenuRoute.extend App.Speakable,
  hideMenu: true

  actions:
    backClick: ->
      @transitionTo 'garden'

    handleCode: (code)->
      @speak 'beep'

      return if @_redirectMatch '^p([0-9]*)$', code, 'plants.show.index'

  _redirectMatch: (regex, code, path)->
    match = new RegExp(regex).exec code.toLowerCase()
    if match
      @transitionTo path, match[1]
      true
    else
      false
