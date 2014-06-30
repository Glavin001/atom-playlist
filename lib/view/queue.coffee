###
authors :
 - Dawson Reid (dreid93@gmail.com)
 -
###

{View} = require 'atom'

class TrackView extends View

  @content: ->
    @li class: 'pl-album', =>
      @div
        class: 'pl-album'
        'Hello World!'

  initialize: (state) ->
    console.log 'TrackView.initialize'
    @state = state

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
          class: 'panel-body'
          style: 'width:100%;'
          outlet: 'list'

    initialize: (state) ->
      console.log 'QueueView.initialize'
      @state=
        tracks: [1..15]
      console.log 'state : ', @state

      if @state.tracks
        console.log 'Initializing startup tracks.'
        # add all of our tracks
        @state.tracks.map (track, index) => @addTrack track
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
      console.log 'QueueView.toggle'
      if @hasParent()
        @detach()
      else
        atom.workspaceView.prependToTop @

    addTrack: (track) ->
      console.log 'add track : ', track
      trackView = new TrackView track
      console.log 'track view : ', trackView
      @list.append trackView
