###
authors :
 - Glavin Wiechert (glavin.wiechert@gmail.com)
 -
###

module.exports =
  class Track
    constructor: (@trackProvider, @meta) ->
      @name = @meta.name
      @artist = @meta.artist
    name: null
    artist: null
