App.SpeciesShowIndexRoute = App.MenuRoute.extend
  model: (params)->
    @modelFor 'species.show'

  actions:
    showPlant: (plant)->
      @transitionTo 'plants.show.index', plant

    addNewPlant: ->
      @transitionTo 'species.show.new_plant', @get('controller.model')
