###
authors :
 - Dawson Reid (dreid93@gmail.com)
 -
###

{View} = require 'atom'
http = require 'http'
util = require 'util'

module.exports =
  class SearchView extends View

    @content: ->
      @div class: 'select-list overlay from-top is-focused', =>
        @div
          class: 'panel-heading'
          'Search for Tracks!'
        @input
          type: 'text'
          class: 'pl-search form-control native-key-bindings'
          placeholder: 'What would you like to listen to?'
          style: 'height: 32px;'
          value: ''
          outlet: 'searchInput'
          keyUp: 'search' # call the search method
          autofocus: true
        @ol class: 'list-group', =>
          @ul
            class: 'event'
            'One'

    ###
    Query Soundcloud for the supplied query string.
    ###
    search: () ->
      console.log 'SearchView.search'
      queryString = util.format(
        "http://api.soundcloud.com/tracks.json?client_id=%s&q=\'%s\'",
        atom.config.get('playlist.clientId'), @searchInput.val())
      console.log 'search uri : ', queryString

      # search soundcloud
      http.get queryString, do (searchView = @) -> # this is coffee closure!!!
        (resp) -> # the http.get callback
          data = ''
          resp.on 'data', (chunk) ->
            #console.log 'chunk :', chunk
            data += chunk.toString()
          resp.on 'end', ->
            #console.log 'data :', data
            results = JSON.parse data
            searchView.loadResultsList results

    ###
    ###
    loadResultsList: (results) ->
      console.log results
      for result in results

    initialize: (state) ->
      console.log 'SearchView.initialize'
      @state = state

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

    toggle: ->
      console.log @, 'toggle'
      if @hasParent()
        @detach()
      else
        atom.workspaceView.append @
