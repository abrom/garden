App.PhotosShowController = App.ModalController.extend
  title: (->
    "Taken " + @get('model.niceDateTaken')
  ).property 'model.niceDateTaken'
