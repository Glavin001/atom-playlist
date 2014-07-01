###
authors :
 - Dawson Reid (dreid93@gmail.com)
 -
###

{View} = require 'atom'
http = require 'http'
util = require 'util'

module.exports =
  class SearchResultView extends View

    @content: (track) ->
      @li class: 'block', =>
        @div
          class: 'inline-block'
          track.title
