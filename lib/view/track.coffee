###
authors :
 - Dawson Reid (dreid93@gmail.com)
 -
###

{View} = require 'atom'

module.exports =
  class TrackView extends View

    @content: ->
      @li class: 'inline-block pl-album', =>
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
