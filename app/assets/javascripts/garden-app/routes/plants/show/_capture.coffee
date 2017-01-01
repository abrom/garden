App.PlantsShowCaptureRoute = App.MenuRoute.extend App.Speakable,
  hideMenu: true

  model: (params)->
    @modelFor 'plants.show'

  actions:
    backClick: ->
      @transitionTo 'plants.show.index', @get('controller.model')

    captureClick: (image)->
      @speak 'boop'
