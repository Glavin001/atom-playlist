###
authors :
 - Glavin Wiechert (glavin.wiechert@gmail.com)
 -
###

{View} = require 'atom'

module.exports =
  class TrackView extends View
    @content: (track) ->
      @li class: 'track two-lines', =>
        @div class: 'status status-added icon ', =>
          @span class: '', outlet: 'trackIcon'
        @div class: 'primary-line no-icon', outlet: "primaryLine", =>
          @span track.name
        @div class: 'secondary-line no-icon', track.artist

    initialize: (@track, @playlist) ->
      @trackIcon.addClass @track.iconClass()
      @refreshView()
      # Bind event listeners
      @playlist.on 'didAddTrack', @refreshView
      @playlist.on 'didRemoveTrack', @refreshView

    refreshView: =>
      # PrimaryLine
      @primaryLine.removeClass "no-icon"
      @primaryLine.removeClass "icon icon-check"
      inPlaylist = @playlist.containsTrack @.track
      # console.log 'inPlaylist: ', inPlaylist
      if inPlaylist
        @primaryLine.addClass "icon icon-check"
      else
        @primaryLine.addClass "no-icon"

    serialize: ->

    destroy: ->
      @detach()
      # Unbind event listeners
      @playlist.removeListener 'didAddTrack', @refreshView
      @playlist.removeListener 'didRemoveTrack', @refreshView
