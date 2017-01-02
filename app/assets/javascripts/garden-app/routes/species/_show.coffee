App.SpeciesShowRoute = App.MenuRoute.extend
  model: (params)->
    @store.findRecord 'species', params.id
