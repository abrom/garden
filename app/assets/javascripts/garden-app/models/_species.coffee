App.Species = DS.Model.extend
  name: DS.attr 'string'
  common_name: DS.attr 'string'
  description: DS.attr 'string'
  authorship: DS.attr 'string'
  source: DS.attr 'string'
  source_id: DS.attr 'string'
  combined_source_id: DS.attr 'string'
  ipni_id: DS.attr 'string'
  publication: DS.attr 'string'
  collation: DS.attr 'string'
  date: DS.attr 'number'
  taxonomic_status: DS.attr 'string'
  confidence_level: DS.attr 'string'
  hybrid: DS.attr 'boolean'

  plantCount: DS.attr 'number'

  genus: DS.belongsTo 'genus'
  plants: DS.hasMany 'plants'

  hasPlants: (->
    @get('plantCount') > 0 || @get('plants.length') > 0
  ).property 'plantCount', 'plants.@each'
