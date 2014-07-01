###
authors :
 - Dawson Reid (dreid93@gmail.com)
 -
###

{View} = require 'atom'

module.exports =
  class SearchView extends View

    @content: ->
      ###
      @div class: 'overlay from-top insert-panel', =>
        @div
          class: 'panel-heading'
          'Search for a track :D'
        @div class: 'panel-body padding', =>
          @div class: 'block', =>
            @div
              class: 'editor mini editor-colors'
              'Search for a track!'
      ###
      @div class: 'select-list overlay from-top is-focused', =>
        @div
          class: 'panel-heading'
          'Search for Tracks!'
        @textarea
          type: 'text'
          class: 'form-control native-key-bindings'
          placeholder: 'What would you like to listen to?'
          style: 'height: 32px;'
          value: ''
          outlet: 'rawSearch'
        @ol class: 'list-group', =>
          @ul
            class: 'event'
            'One'

    initialize: (state) ->
      console.log 'SearchView.initialize'
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
      console.log @, 'toggle'
      if @hasParent()
        @detach()
      else
        atom.workspaceView.append @
