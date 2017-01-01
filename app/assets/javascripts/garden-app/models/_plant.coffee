App.Plant = DS.Model.extend
  species: DS.belongsTo 'species'
  photos: DS.hasMany 'photos'
