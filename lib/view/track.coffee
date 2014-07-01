###
authors :
 - Dawson Reid (dreid93@gmail.com)
 -
###

{View} = require 'atom'

util = require 'util'

module.exports =
  class TrackView extends View

    @content: (track) ->
      @li class: 'inline-block pl-album', =>
        @div
          class: 'pl-album', =>
            @div
              class: ''
              track.title

    initialize: (track) ->
      console.log 'TrackView.initialize'
      @track = track

      if track.stream_url
        @context = new webkitAudioContext()
        @audio = new Audio()
        @url = track.stream_url +
          util.format '?client_id=%s', atom.config.get('playlist.clientId');
        console.log 'streaming url :', @url

        @audio.src = @url;
        @source = @context.createMediaElementSource(@audio);
        @source.connect(@context.destination);
        @source.mediaElement.play();

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
