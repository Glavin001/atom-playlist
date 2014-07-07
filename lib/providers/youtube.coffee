###
authors :
 - Glavin Wiechert (glavin.wiechert@gmail.com)
 -
###

# See https://www.npmjs.org/package/youtube-node
# Get key from https://www.youtube.com/watch?v=Im69kzhpR3I

TrackProvider = require '../models/track_provider'

module.exports =
  class TrackProvider extends TrackProvider
    search: (query, callback) ->
      if not query?
        return callback?(null, [])

      t = new @Track({
        'name': query,
        'artist': 'YouTube'
        })
      console.log t
      callback?(null, [t])
