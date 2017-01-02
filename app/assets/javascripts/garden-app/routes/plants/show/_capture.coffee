App.PlantsShowCaptureRoute = App.MenuRoute.extend App.Speakable,
  hideMenu: true

  model: (params)->
    @modelFor 'plants.show'

  actions:
    backClick: ->
      @transitionTo 'plants.show.index', @get('controller.model')

    captureClick: (image)->
      @speak 'boop'

      data = new FormData()
      data.append 'photo[image]', image
      data.append 'photo[plant_id]', @get('controller.model.id')

      $.ajax
        url: "/api/v1/photos"
        type: 'POST'
        data: data
        contentType: false
        processData: false
        success: (data)=>
          @get('store').pushPayload data
          @transitionTo 'plants.show.index', @get('controller.model')
