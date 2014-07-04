###
authors :
 - Dawson Reid (dreid93@gmail.com)
 - Glavin Wiechert (glavin.wiechert@gmail.com)
###

{View} = require 'atom'
TrackView = require './track_view'

module.exports =
  class PlaylistView extends View
    ###
    This is a list of Albums.
    ###
    @content: ->
      @div class: 'playlist pane pl-queue', =>
        @div
          class: 'panel-heading', =>
            @span 'Playlist', style: 'margin-right: 1em;'
            @span class: 'icon icon-x', click: 'close'
        @ul
          class: 'current-track col-md-1',
          outlet: 'currentTrack'
        @ul
          class: 'col-md-11'
          # style: 'width:100%;'
          outlet: 'list'

    initialize: (@playlist) ->
      console.log 'QueueView.initialize'
      console.log 'playlist : ', @playlist

      # Initialize
      if @playlist.tracks
        console.log 'Initializing startup tracks.'
        # add all of our tracks
        @playlist.tracks.map (track, index) => @pushTrack track
      else
        console.log 'No tracks loaded on startup.'

      # Bind event listeners
      @playlist.on 'didAddTrack', @pushTrack
      @playlist.on 'didRemoveTrack', @removeTrack
      @playlist.on 'currentTrackChanged', @updateCurrentTrack

    ###
    Returns an object that can be retrieved when package is activated
    ###
    serialize: ->
      return

    ###
    Tear down any state and detach
    ###
    destroy: ->
      @detach()
      # Unbind event listeners
      @playlist.removeListener 'didAddTrack', @pushTrack
      @playlist.removeListener 'didRemoveTrack', @removeTrack
      @playlist.removeListener 'currentTrackChanged', @updateCurrentTrack


    open: ->
      # atom.workspaceView.append(this)
      atom.workspaceView.prependToTop @

    close: ->
      @detach()

    isOpen: ->
      @hasParent()

    toggle: ->
      if @isOpen()
        @close()
      else
        @open()

    pushTrack: (track) =>
      console.log 'add track : ', track
      trackView = new TrackView track
      #console.log 'track view : ', trackView
      @list.append trackView

    ### TODO: popTrack
    Takes a track off of the front of the queue and returns the track's state.
    ###
    popTrack: () ->
      console.log @, 'popTrack'
      return

    ### TODO: insertTrack
    Inserts a track at position `pos` in the queue and returns the `trackId`.
    ###
    insertTrack: (track, position) ->
      console.log @, 'insertTrack'
      return

    ### removeTrack
    Removes a track, trackId and returns the state of the
    removed track.
    ###
    removeTrack: (track) =>
      # console.log 'removeTrack', track, @list
      sel = "[data-track-provider=\"#{track.provider.name}\"]"+
        "[data-track-id=\"#{track.id}\"]"
      trackView =
        @list.find(sel)
      # console.log trackView
      trackView.remove()

    updateCurrentTrack: (track) =>
      console.log "updateCurrentTrack", track
      # Clear
      @currentTrack.empty()
      # Append to front
      trackView = new TrackView track
      @currentTrack.prepend trackView
