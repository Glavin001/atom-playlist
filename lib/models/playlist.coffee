###
authors :
 - Glavin Wiechert (glavin.wiechert@gmail.com)
 -
###

EventEmitter = require('events').EventEmitter

module.exports =
  class Playlist extends EventEmitter
    tracks: []
    constructor: ->
    addTrack: (track) ->
      @tracks.push(track)
      @emit('addTrack', track)
    removeTrack: (track) ->
      index = @tracks.indexOf(track)
      if index > -1
        @tracks.splice(index, 1)
      @emit('removeTrack', track)
