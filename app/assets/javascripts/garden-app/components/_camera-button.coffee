App.CameraButtonComponent = Em.Component.extend
  classNameBindings: ['buttonClasses']

  description: (->
    label = @get 'camera.label'
    if label
      if label.match /front/i
        'Front'
      else if label.match /back/i
        'Back'
  ).property 'camera.label'

  buttonClasses: (->
    classes = 'btn btn-primary btn-sq-md'
    classes += ' flex-center' unless @get 'description'
    classes
  ).property 'description'

  actions:
    clicked: ->
      @sendAction 'clicked', @get('camera')
