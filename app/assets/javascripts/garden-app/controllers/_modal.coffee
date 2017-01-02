App.ModalController = Em.Controller.extend
  actions:
    close: ->
      @send 'closeModal'
