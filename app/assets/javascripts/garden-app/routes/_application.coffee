App.ApplicationRoute = Em.Route.extend
  actions:
    openModal: (modalName, model)->
      @render modalName,
        into: 'application',
        outlet: 'modal'
        model: model

    closeModal: ->
      @disconnectOutlet
        outlet: 'modal'
        parentView: 'application'
