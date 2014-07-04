###
authors :
 - Glavin Wiechert (glavin.wiechert@gmail.com)
 -
###
EventEmitter = require('events').EventEmitter

module.exports =
  class Track extends EventEmitter
    constructor: (@provider, @meta) ->
      @id = @meta.id
      @name = @meta.name
      @artist = @meta.artist
    id: null
    name: null
    artist: null

    iconClass: ->
      # console.log @provider
      @provider.iconClass()

    play: (callback) ->
      @emit "willPlay"
      @provider.playTrack @, callback
      @emit "didPlay"

    isPlaying: (callback) ->
      @provider.isPlaying @, callback

    isFinished: (callback) ->
      @provider.isFinished @, callback
