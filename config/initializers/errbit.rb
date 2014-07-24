Airbrake.configure do |config|
  config.api_key = 'c2a62165b44c44b9c57e0c30136400ab'
  config.host    = 'x.piersonally.com'
  config.port    = 443
  config.secure  = config.port == 443
end
