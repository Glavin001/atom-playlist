###
# This file is the entry point of your package. It will be loaded once as a
# singleton.
#
# For more information:
#   https://atom.io/docs/latest/creating-a-package#source-code
###

###
authors :
 - Dawson Reid (dreid93@gmail.com)
 - Glavin Wiechert (glavin.wiechert@gmail.com)
###

# Models
TrackProviders = require "./providers/"
console.log TrackProviders
Playlist = require "./models/playlist"
# Views
SearchView = require "./views/search_view"
PlaylistView = require "./views/playlist_view"
# Utils
util = require 'util'
winston = require 'winston'

module.exports =

  configDefaults:
    soundCloudClientId: '9a793fcdbbe6e69c6043fe2780283af9'
    soundCoudClientSecret: '5fb0ba150973d4e29fef57c33258a99f'

  ###
  Setup our logging framework. Here we are using winston.

  FIXME: Winston logging is currently not working.
  ###
  setupLogging: ->
    logger = new (winston.Logger)({
      transports: [
        new (winston.transports.Console)()
      ]
    })
    console.log logger
    logger.info 'Setup Winston logger.'

  ###
  Setup package commands.
  ###
  setupCommands: ->

    workspace = atom.workspaceView
    # Playlist
    workspace.command 'playlist:togglePlaylist', => @playlistView.toggle()
    # Search
    workspace.command 'playlist:toggleSearch', => @searchView.toggle()

  ###
  # This required method is called when your package is activated. It is passed
  # the state data from the last time the window was serialized if your module
  # implements the serialize() method. Use this to do initialization work when
  # your package is started (like setting up DOM elements or binding events).
  ###
  activate: (state) ->
    console.log 'activate ', state

    @setupLogging()
    @trackProviders = TrackProviders
    @searchView = new SearchView(@trackProviders)
    @playlist = new Playlist()
    @playlistView = new PlaylistView(@playlist)

    atom.config.observe 'playlist.clientId', {}, (clientId) ->
      console.log 'client id :', clientId

    @setupCommands()
    return

  ###
  # This optional method is called when the window is shutting down, allowing
  # you to return JSON to represent the state of your component. When the
  # window is later restored, the data you returned is passed to your module's
  # activate method so you can restore your view to where the user left off.
  ###
  serialize: ->
    console.log 'serialize()'

  ###
  # This optional method is called when the window is shutting down. If your
  # package is watching any files or holding external resources in any other
  # way, release them here. If you're just subscribing to things on window, you
  # don't need to worry because that's getting torn down anyway.
  ###
  deactivate: ->
    console.log 'deactivate()'
    @queueView.destroy()
