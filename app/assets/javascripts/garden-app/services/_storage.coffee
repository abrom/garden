# Based on ember-storage https://github.com/jerel/ember-storage

storage =
  local: window.localStorage
  session: window.sessionStorage

App.Storage = Em.Service.extend
  prefix: 'es'
  type: 'local'

  _prefix: (key)->
    @get('prefix') + '__' + key

  setUpEventListener: (->
    regexp = new RegExp '^(' + @get('prefix') + '__)'
    @_notify = (evnt)=> @notifyPropertyChange evnt.key.replace(regexp, '')
    window.addEventListener 'storage', @_notify, false
  ).on 'init'

  willDestroy: ->
    @_super()
    window.removeEventListener 'storage', @_notify, false

  unknownProperty: (k)->
    key = @_prefix k
    type = @get 'type'
    # if we don't use JSON.parse here then observing a boolean doesn't work
    storage[type][key] && JSON.parse(storage[type][key])

  setUnknownProperty: (k, value)->
    key = @_prefix k
    type = @get 'type'

    if Em.isNone value
      delete storage[type][key]
    else
      storage[type][key] = JSON.stringify value

    @notifyPropertyChange k
    value

  clear: (keyPrefix)->
    @beginPropertyChanges()
    prefix = keyPrefix || @get('prefix')
    regexp = new RegExp '^(' + prefix + '__)'
    type = @get 'type'
    toDelete = []

    for i in [0..storage[type].length]
      key = storage[type].key i
      # don't nuke *everything* in localStorage... just keys that match our pattern
      if key.match regexp
        toDelete.push key

    toDelete.forEach (key)->
      delete storage[type][key]
      key = key.replace regexp, ''
      @set key
    , @
    @endPropertyChanges()
