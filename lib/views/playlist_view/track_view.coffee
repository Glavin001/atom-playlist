###
authors :
 - Glavin Wiechert (glavin.wiechert@gmail.com)
 -
###

{View} = require 'atom'

module.exports =
  class TrackView extends View
    @content: (track) ->
      @li
        class: 'track two-lines inline-block pl-album',
        'data-track-provider': track.provider.name,
        'data-track-id': track.id,
        =>
          @div class: 'status status-added icon ', =>
            @span class: 'pl-album', outlet: 'trackIcon'
          @div class: 'primary-line no-icon', outlet: "primaryLine", =>
            @span track.name
          @div class: 'secondary-line no-icon', track.artist

    initialize: (@track) ->
      @trackIcon.addClass @track.iconClass()

    serialize: ->

    destroy: ->
      @detach()
