App.SelectInputComponent = Em.Component.extend
  tagName: 'select'

  change: ->
    index = @element.selectedIndex
    index -= 1 if @get 'placeholder'
    @set 'selected', @get('options')[index]
