###
authors :
 - Glavin Wiechert (glavin.wiechert@gmail.com)
 -
###

{View} = require 'atom'

module.exports =
  class TrackView extends View
    @content: (track) ->
      @li class: 'track', =>
        @div class: 'status status-added icon icon-diff-added', ''
        @div class: 'primary-line', =>
          @span class: 'track-icon fa fa-music'
          @span track.name
        @div class: 'secondary-line no-icon', track.artist

    initialize: (@track) ->

    serialize: ->

    destroy: ->
      @detach()
