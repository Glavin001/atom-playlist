###
authors :
 - Glavin Wiechert (glavin.wiechert@gmail.com)
 -
###

Track = require './track'

module.exports =
  class TrackProvider
    Track: (meta) ->
      console.log @, meta
      return new Track(@, meta)
    constructor: ->

    search: (query, callback) ->
      if not query?
        return callback?(null, [])

      t = new @Track({
        'name': query,
        'artist': 'USER'
        })
      console.log t
      callback?(null, [t])
