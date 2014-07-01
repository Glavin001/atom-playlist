###
authors :
 - Dawson Reid (dreid93@gmail.com)
 -
###

{View} = require 'atom'

module.exports =
  class TrackView extends View

    @content: (track) ->
      @li class: 'inline-block pl-album', =>
        @div
          class: 'pl-album', =>
            @div
              class: ''
              track.title

    initialize: (track) ->
      console.log 'TrackView.initialize'
      @track = track

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
