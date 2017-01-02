App.PlantsShowIndexRoute = App.MenuRoute.extend
  model: (params)->
    @modelFor('plants.show');

  actions:
    addPhoto: ->
      @transitionTo 'plants.show.capture', @get('controller.model')

    showPhoto: (photo)->
      @send 'openModal', 'photos.show', photo
