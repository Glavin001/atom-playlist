###
authors :
 - Glavin Wiechert (glavin.wiechert@gmail.com)
 -
###

{SelectListView} = require 'atom'
TrackView = require './track_view'

module.exports =
  class SearchView extends SelectListView

    searchThrottle: 100

    initialize: (@trackProviders) ->
      super
      @addClass('overlay from-top')
      @addClass('track-search')

    viewForItem: (track) ->
      return new TrackView(track)

    confirmed: (track) ->
      console.log("#{track.name} was selected")

    populateList: ->

      clearTimeout(@scheduleSearch)
      @setLoading "Stop typing to search"

      searchCallback = =>
        @setLoading "Loading.."
        filterQuery = @getFilterQuery()
        console.log "populateList!", filterQuery

        @trackProviders.search filterQuery, (error, tracks) =>
          if not error?
            @items = tracks
            super
            @setLoading()

      @scheduleSearch = setTimeout(searchCallback,  @searchThrottle)

    getFilterKey: -> "name"

    open: ->
      atom.workspaceView.append(this)
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
