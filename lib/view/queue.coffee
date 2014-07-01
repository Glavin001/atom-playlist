###
authors :
 - Dawson Reid (dreid93@gmail.com)
 -
###

{View} = require 'atom'
TrackView = require './track'

module.exports =
  class QueueView extends View
    ###
    This is a list of Albums.
    ###

    @fixtures=
      tracks: ['one', 'two', 'three']

    @content: ->
      @div class: 'pane pl-queue', =>
        @div
          class: 'panel-heading'
          'Playlist Queue'
        @ul
          class: 'block'
          style: 'width:100%;'
          outlet: 'list'

    initialize: (state) ->
      console.log 'QueueView.initialize'
      @state = state
      console.log 'state : ', @state

      if @state.tracks
        console.log 'Initializing startup tracks.'
        # add all of our tracks
        @state.tracks.map (track, index) => @pushTrack track
      else
        console.log 'No tracks loaded on startup.'

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

    toggle: ->
      console.log @, 'toggle'
      if @hasParent()
        @detach()
      else
        atom.workspaceView.prependToTop @

    pushTrack: (track) ->
      console.log 'add track : ', track
      trackView = new TrackView track
      console.log 'track view : ', trackView
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

    ### TODO: removeTrack
    Removes a track with the track id, trackId and returns the state of the
    removed track.
    ###
    removeTrack: (trackId) ->
      console.log @, 'removeTrack'
      return
