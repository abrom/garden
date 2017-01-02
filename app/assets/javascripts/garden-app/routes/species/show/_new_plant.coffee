App.SpeciesShowNewPlantRoute = App.MenuRoute.extend
  model: (params)->
    @modelFor 'species.show'

  actions:
    createPlant: ->
      plant = @store.createRecord 'plant',
        species: @get('controller.model')

      plant.save().then =>
        @transitionTo 'plants.show.index', plant
