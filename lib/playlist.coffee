###
# This file is the entry point of your package. It will be loaded once as a
# singleton.
#
# For more information:
#   https://atom.io/docs/latest/creating-a-package#source-code
###

winston = require 'winston'
QueueView = require './view/queue'
SearchView = require './view/search'

module.exports =

  configDefaults:
    clientId: '072891b4ca0d6d02c31c2abb82bd3f63'

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
    workspace.command 'playlist:toggleQueue', => @toggleQueue()
    workspace.command 'playlist:toggleSearch', => @toggleSearch()

  ###
  # This required method is called when your package is activated. It is passed
  # the state data from the last time the window was serialized if your module
  # implements the serialize() method. Use this to do initialization work when
  # your package is started (like setting up DOM elements or binding events).
  ###
  activate: (state) ->
    console.log 'activate ', state

    @setupLogging()
    @setupCommands()

    @queueView = new QueueView state
    @searchView = new SearchView state

    atom.config.observe 'playlist.clientId', {}, (clientId) =>
      console.log 'client id :', clientId

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

  ###
  Toggle the queue.
  ###
  toggleQueue: ->
    console.log 'toggleQueue()'
    @queueView.toggle()

  toggleSearch: ->
    console.log 'toggleSearch()'
    @searchView.toggle()
