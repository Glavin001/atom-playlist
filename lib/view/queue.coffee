###
authors :
 - Dawson Reid (dreid93@gmail.com)
 -
###

{View} = require 'atom'

module.exports =
  class QueueView extends View

    @content: ->
      @div class: 'overlay from-top panel', =>
        @div
          class: 'panel-heading'
          'Playlist Queue'

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
      if @hasParent()
        @detach()
      else
        atom.workspaceView.append(this)
