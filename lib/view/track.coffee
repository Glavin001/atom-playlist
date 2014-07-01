###
authors :
 - Dawson Reid (dreid93@gmail.com)
 -
###

{View} = require 'atom'

util = require 'util'
stream = require('soundcloud-stream')(atom.config.get 'playlist.clientId')

module.exports =
  class TrackView extends View

    @content: (track) ->
      @li class: 'inline-block pl-album', =>
        @div
          class: 'pl-album', =>
            @div
              class: ''
              track.title
            @div
              outlet: 'audioDiv'

    initialize: (track) ->
      console.log 'TrackView.initialize'
      @track = track

      if track.stream_url
        ###
        @context = new webkitAudioContext()
        @url = track.stream_url +
          util.format '?client_id=%s', atom.config.get 'playlist.clientId'
        console.log 'streaming url :', @url

        @audio = new Audio()
        @audio.src = @url
        #@audioDiv.append @audio

        @audio.addEventListener 'canplaythrough', do (track = @) ->
          console.log 'audio can play through'
          track.source = track.context.createMediaElementSource track.audio
          track.source.connect track.context.destination
          track.source.mediaElement.play()
        ###
        stream track.stream_url, (err, sound) ->
          sound.play()

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
