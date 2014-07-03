TrackProviders = require "../models/track_providers"
# Init the Providers class
module.exports = providers = new TrackProviders()
# Add the Providers
add = (pPath) ->
  provider = require pPath
  providers.add(new provider())
# Custom Providers
add('./itunes')
add('./soundcloud')
add('./youtube')
