###
authors :
 - Glavin Wiechert (glavin.wiechert@gmail.com)
 -
###

EventEmitter = require('events').EventEmitter
Track = require './track'

module.exports =
  class TrackProvider extends EventEmitter
    # Name of the Provider
    name: null
    # Cache of all Tracks for this Provider, indexed by `id`
    _cache: {}

    Track: (meta) =>
      # console.log @, meta
      # Verify there is an `id` field
      id = meta.id
      if not id?
        throw new Error "Track must have a valid value for it's `id` field."
      # Check if a Track already exists
      track = @_cache[id]
      if not track?
        # Create new track
        track = new Track(@, meta)
        # Cache the new track
        @_cache[id] = track
      # Return the track
      return track

    constructor: ->
      if not @name?
        throw new Error "TrackProvider subclasses must set the `name` property."

    iconClass: ->
      "track-icon track-#{@name}"

    search: (query, callback) ->
      throw new Error(
        "TrackProvider, #{@name}, must override the `search` function.")

      # if not query?
      #   return callback?(null, [])
      # t = new @Track({
      #   'id': '1234567890',
      #   'name': query,
      #   'artist': 'USER'
      #   })
      # console.log t
      # callback?(null, [t])

    playTrack: (track, callback) ->
      throw new Error(
        "TrackProvider, #{@name}, must override the `playTrack` function.")
