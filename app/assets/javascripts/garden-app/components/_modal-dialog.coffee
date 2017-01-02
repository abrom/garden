App.ModalDialogComponent = Em.Component.extend
  show: (->
    @$('.modal').modal().on 'hidden.bs.modal', => @sendAction 'close'
  ).on 'didInsertElement'

  modalSize: (->
    switch @get 'size'
      when 'large' then 'modal-lg'
      when 'small' then 'modal-sm'
      else ''
  ).property 'size'
