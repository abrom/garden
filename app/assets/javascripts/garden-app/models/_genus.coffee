App.Genus = DS.Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  hybrid: DS.attr 'boolean'

  species: DS.hasMany 'species'
