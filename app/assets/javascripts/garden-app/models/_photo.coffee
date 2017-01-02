App.Photo = DS.Model.extend
  url: DS.attr 'string'
  thumbUrl: DS.attr 'string'
  dateTaken: DS.attr 'date'

  plant: DS.belongsTo 'plant'

  niceDateTaken: (->
    moment(@get('dateTaken')).format 'dddd, MMMM Do YYYY [at] h:mm a'
  ).property 'dateTaken'
