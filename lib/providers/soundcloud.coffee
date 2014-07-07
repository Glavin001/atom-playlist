###
authors :
 - Glavin Wiechert (glavin.wiechert@gmail.com)
 -
###

# SC = require "soundclouder"
TrackProvider = require '../models/track_provider'

module.exports =
  class TrackProvider extends TrackProvider
    clientId: "9a793fcdbbe6e69c6043fe2780283af9"
    clientSecret: "5fb0ba150973d4e29fef57c33258a99f"
    constructor: () ->
      super
      # SC.init({
      #   client_id: @clientId
      #   client_secret: @clientSecret
      #   })
    search: (query, callback) ->
      if not query?
        return callback?(null, [])

      # SC.get("/tracks", {q:query})
      t = new @Track({
        'name': query,
        'artist': 'SoundCloud'
        })
      console.log t
      callback?(null, [t])
