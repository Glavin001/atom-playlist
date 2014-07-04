###
authors :
 - Glavin Wiechert (glavin.wiechert@gmail.com)
 -
###

EventEmitter = require('events').EventEmitter

module.exports =
  class Playlist extends EventEmitter
    tracks: []
    currentTrack: null

    constructor: ->
      @.setMaxListeners(100) # FIXME

    destroy: ->

    addTrack: (track) =>
      # console.log "addTrack", track
      @emit "willAddTrack", track
      @tracks.push(track)
      @emit "didAddTrack", track

      @runStep() # FIXME
    removeTrack: (track) =>
      # console.log "removeTrack", track
      @emit "willRemoveTrack", track
      index = @tracks.indexOf(track)
      if index > -1
        @tracks.splice(index, 1)
        @emit 'didRemoveTrack', track, true
      else
        @emit "didRemoveTrack", track, false

      @runStep() # FIXME
    containsTrack: (track) ->
      # console.log 'containsTrack', track, @tracks
      index = @tracks.indexOf(track)
      # console.log index
      if index > -1
        return true
      else
        return false

    isCurrentTrack: (track) =>
      return track is @currentTrack

    runStep: =>
      if not @currentTrack?
        # Get a current track
        if @tracks.length > 0
          @emit "willRemoveTrack", @tracks[0]
          @currentTrack = @tracks.shift()
          @emit 'didRemoveTrack', @currentTrack, true
          @emit "currentTrackChanged", @currentTrack
          # console.log 'currentTrack', @currentTrack
          # Listen for finish events
          @currentTrack.on "finishedPlaying", @runStep
          # Play!
          @currentTrack.play()
        else
          # No tracks in playlist
          console.log "No tracks in playlist"
          return
      else
        # Has a current track
        # Check if still playing
        @currentTrack.isPlaying((isPlaying) =>
          if isPlaying
            console.log "isPlaying"
            # is still playing
            return
          else
            # No longer playing
            console.log "Not playing"
            # Check if is finished
            @currentTrack.isFinished((isFinished) =>
              console.log "isFinished", isFinished
              if isFinished
                # Stop listening to track's events
                @currentTrack.removeListener "finishedPlaying", @runStep
                # Clear currentTrack
                @currentTrack = null
                # Execute runStep which will get the next track
                @runStep()
              )
          )
