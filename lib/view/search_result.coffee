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
          class: 'inline-block btn'
          click: 'addTrack', =>
            @i class: 'fa fa-plus'
        @div
          class: 'inline-block'
          track.title

    initialize: (track, queue) ->
      console.log 'SearchResultView.initialize'
      @track = track
      @queue = queue

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

    addTrack: ->
      console.log 'SearchResultView.addTrack'
      @queue.pushTrack @track
