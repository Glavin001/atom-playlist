###
authors :
 - Glavin Wiechert (glavin.wiechert@gmail.com)
 -
###

async = require 'async'
_ = require 'lodash'
Track = require './track'

module.exports =
  class TrackProviders
    providers: []

    constructor: ->

    add: (provider) ->
      @providers.push(provider)

    remove: (provider) ->
      index = @providers.indexOf(provider)
      if index > -1
        @providers.splice(index, 1)

    # Search all Providers
    search: (query, callback) ->
      # Put all searcher functions in an array
      async.map(@providers,
        (provider, pcb) ->
          console.log 'provider', provider
          pcb(null, (cb) ->
            provider.search query, cb
          )
        , (err, searchFuns) ->
          console.log 'searchFuns', err, searchFuns
          # Search!
          async.parallel(searchFuns, (err, results) ->
            console.log 'search results', err, results
            # Flatten the results to a single array of tracks
            tracks = _.flatten(results)
            console.log tracks
            callback?(err, tracks)
            )
        )
