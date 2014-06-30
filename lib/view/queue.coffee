###
authors :
 - Dawson Reid (dreid93@gmail.com)
 -
###

{View} = require 'atom'

module.exports =
  class QueueView extends View

    @content: ->
      @div class: 'pane playlist-queue', =>
        @div
          class: 'panel-heading'
          'Playlist Queue'
        @div
          class: 'panel-body padded',
          outlet: 'body',
          style: 'width:100%;'

    initialize: (state) ->
      console.log 'QueueView.initialize'
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

    toggle: ->
      console.log 'QueueView.toggle'
      if @hasParent()
        @detach()
      else
        atom.workspaceView.prependToTop @
