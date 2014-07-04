###
authors :
 - Glavin Wiechert (glavin.wiechert@gmail.com)
 -
###


applescript = require "applescript"
TrackProvider = require '../models/track_provider'

module.exports =
  class TrackProvider extends TrackProvider
    name: "itunes"

    constructor: ->
      super
      # Listen for tracks starting to play.
      @.on "didPlayTrack", @_finishLoop

    search: (query, callback) =>
      if not query?
        return callback?(null, [])
      script = """
          tell application "iTunes"
            --activate
            set results to (every file track of playlist ¬
              "Library" whose name contains "#{query}" ¬
              or artist contains "#{query}")
            set ts to {}
            repeat with t in results
              set c to {id of t, name of t, artist of t}
              set end of ts to c
            end repeat
            return ts
          end tell
          """
      applescript.execString(script, (err, results) =>
        if (err)
          # console.log err
          return callback?(err, [])

        # console.log results
        allTracks = []
        if results?
          # Fix results if too many
          results = results[0...10] if results.length > 10
          # Add all tracks that made it to the shortlist
          for t in results
            t = new @Track({
              'id': t[0]
              'name': t[1]
              'artist': t[2]
              })
            allTracks.push(t)
            # console.log t
        # console.log allTracks
        callback?(null, allTracks)
        )

    playTrack: (track, callback) =>
      # console.log "iTunes Play track", track
      @emit "willPlayTrack", track
      script = """
        tell application "iTunes"
          play item 1 of (every track of playlist "Library" ¬
          whose id is #{track.id}) with once
        end tell
        """
      applescript.execString(script, (err, results) =>
        # console.log err
        @emit "didPlayTrack", track, err
        return callback?(err)
      )

    isPlaying: (track, callback) ->
      # console.log "isPlaying", track
      script = """
        tell application "iTunes"
        	if player state is playing then
        		return true
        	else
        		return false
        	end if
        end tell
      """
      applescript.execString(script, (err, results) ->
        # console.log err, results, @
        if err
          return callback?(false)
        else
          return callback?(if results is "true" then true else false)
      )

    isFinished: (track, callback) ->
      # console.log "isFinished", track

      script = """
        tell application "iTunes"
        	return {duration, start, finish} of current track & {player position}
        end tell
      """
      applescript.execString(script, (err, results) ->
        # console.log err, results, @
        if err or not results?
          return callback?(true)
        else
          return callback?(if results[2] <= results[3] then true else false)
      )

    _finishLoop: (track) =>
      console.log '_finishLoop', track
      @isFinished track, (isFinished) =>
        if isFinished
          console.log "HAS FINISHED"
          track.emit "finishedPlaying", track
        else
          console.log "nope, not finished.."
          setTimeout () =>
            @_finishLoop track
          , 500
