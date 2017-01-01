App.MenuRoute = Em.Route.extend
  setupController: (controller, model)->
    @_super controller, model
    @controllerFor('application').set 'hideMenu', @get('hideMenu')
