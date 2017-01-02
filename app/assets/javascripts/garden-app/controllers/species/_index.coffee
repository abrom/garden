App.SpeciesIndexController = Em.Controller.extend
  filtered: (->
    query = @get('queryLowercase')
    @get('species').filter (item)-> item.get('name').startsWith query
  ).property 'query', 'species.@each'

  species: (->
    @store.findAll 'species'
  ).property()

  localFilteredCount: Em.computed.alias 'filtered.length'

  speciesSorting: ['name']
  sorted: Em.computed.sort 'filtered', 'speciesSorting'

  query: ''
  queryLowercase: (->
    @get('query').toLowerCase()
  ).property 'query'

  onQueryChange: (->
    Em.run.debounce @, @_runSearch, 500
  ).observes 'query'

  actions:
    showSpecies: (species)->
      @transitionToRoute 'species.show', species

  _runSearch: ->
    @store.query('species',
      query: @get 'queryLowercase'
      limit: 20
    ).then (species)=>
      meta = species.get('meta')
      @setProperties
        totalCount: meta.total
        filteredCount: meta.filtered
