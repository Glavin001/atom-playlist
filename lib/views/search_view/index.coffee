###
authors :
 - Glavin Wiechert (glavin.wiechert@gmail.com)
 -
###

{SelectListView} = require 'atom'
TrackView = require './track_view'

module.exports =
  class SearchView extends SelectListView
    # cancel: -> # Disable Cancel for debugging by overriding function

    searchThrottle: 100

    initialize: (@trackProviders, @playlist) ->
      super
      @addClass('overlay from-top track-search')

    viewForItem: (track) ->
      return new TrackView(track, @playlist)

    confirmed: (track) ->
      # console.log("#{track.name} by #{track.artist} was selected")
      if @playlist.containsTrack track
        @playlist.removeTrack track
      else
        @playlist.addTrack track

    populateList: ->
      clearTimeout(@scheduleSearch)
      @setLoading "Stop typing to search"
      searchCallback = =>
        @setLoading "Loading.."
        filterQuery = @getFilterQuery()
        # console.log "populateList!", filterQuery
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
