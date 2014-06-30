###
# This file is the entry point of your package. It will be loaded once as a
# singleton.
#
# For more information:
#   https://atom.io/docs/latest/creating-a-package#source-code
###

module.exports =

  ###
  Setup our logging framework. Here we are using winston.

  FIXME: Winston logging is currently not working. 
  ###
  setupLogging: ->
    winston = require 'winston'
    logger = new (winston.Logger)({
      transports: [
        new (winston.transports.Console)()
      ]
    })
    console.log logger
    logger.info 'Setup Winston logger.'

  initQueueView: ->
    return

  ###
  Setup package commands.
  ###
  setupCommands: ->

    workspace = atom.workspaceView
    workspace.command 'playlist:toggleQueue', => @toggleQueue()

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
    @initQueueView()
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

  ###
  Toggle the queue.
  ###
  toggleQueue: ->
    console.log 'toggleQueue()'
