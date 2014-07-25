Airbrake.configure do |config|
  config.api_key = 'c2a62165b44c44b9c57e0c30136400ab'
  config.host    = 'x.piersonally.com'
  config.port    = 80
  config.secure  = config.port == 443
end

# Errbit error catching for Sidekiq workers
Sidekiq.configure_server do |config|
  config.error_handlers << Proc.new { |ex,ctx_hash| Airbrake.notify(ex, ctx_hash) }
end
