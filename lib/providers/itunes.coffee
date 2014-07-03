###
authors :
 - Glavin Wiechert (glavin.wiechert@gmail.com)
 -
###

TrackProvider = require '../models/track_provider'

module.exports =
  class TrackProvider extends TrackProvider
    search: (query, callback) ->
      if not query?
        return callback?(null, [])

      t = new @Track({
        'name': query,
        'artist': 'iTunes'
        })
      console.log t
      callback?(null, [t])
