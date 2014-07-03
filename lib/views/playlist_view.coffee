###
authors :
 - Glavin Wiechert (glavin.wiechert@gmail.com)
 -
###

{SelectListView} = require 'atom'
TrackView = require './track_view'

module.exports =
  class SearchView extends SelectListView
    initialize: (@playlist) ->
      super
      @addClass('overlay from-top')
      # @setItems([])

    viewForItem: (track) ->
      return new TrackView(track)

    confirmed: (tracks) ->
      console.log("#{tracks} was selected")

    populateList: ->
      # console.log "populateList!", filterQuery
      @items = @playlist.tracks
      super

    getFilterKey: -> "name"

    open: ->
      # atom.workspaceView.append(this)
      atom.workspaceView.prependToTop @
      @focusFilterEditor()

    close: ->
      @detach()

    isOpen: ->
      @hasParent()

    toggle: ->
      if @isOpen()
        @close()
      else
        @open()
