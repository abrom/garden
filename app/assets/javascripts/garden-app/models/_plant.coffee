App.Plant = DS.Model.extend
  dateAdded: DS.attr 'date'

  species: DS.belongsTo 'species'
  photos: DS.hasMany 'photos'

  photosSorting: ['dateTaken']
  sortedPhotos: Em.computed.sort 'photos', 'photosSorting'
  mostRecentPhoto: Em.computed.alias 'sortedPhotos.firstObject'

  niceDateAdded: (->
    moment(@get('dateAdded')).format 'dddd, MMMM Do YYYY [at] h:mm a'
  ).property 'dateAdded'