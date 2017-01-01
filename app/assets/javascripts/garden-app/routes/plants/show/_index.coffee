App.PlantsShowIndexRoute = App.MenuRoute.extend
  model: (params)->
    @modelFor('plants.show');
