App.PlantsShowRoute = App.MenuRoute.extend
  model: (params)->
    @store.findRecord('plant', params.id)
