require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MyChat
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    
  
    config.action_cable.url = 'http://localhost:3000/cable'
    config.web_socket_server_url = 'ws://localhost:3000/cable'
    #  config.action_cable.allowed_request_origins = [
    #     # Local address of our RoR server
    #    'http://localhost:3000',
    #     # Local address we use for our React standalone client
    #    'http://localhost:8000',
    #  ]
  
    config.action_cable.allowed_request_origins = [/http:\/\/*/, /https:\/\/*/, /ws:\/\/*/, /wss:\/\/*/]
    config.action_cable.disable_request_forgery_protection = true
    
    
    
    
    config.active_record.default_timezone = :utc
    # config.i18n.default_locale = :"pt-BR"
    I18n.enforce_available_locales = false
    # config.active_record.raise_in_transactional_callbacks = true

    config.action_dispatch.default_headers.merge!({
      'Access-Control-Allow-Origin' => '*',
      'Access-Control-Request-Method' => '*'
    })

    # configuracao de acesso a API (Web Service API)
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :options]
      end
    end

    config.serve_static_assets = true
    config.assets.enabled = false
    config.assets.precompile = []
    
    # Date
    # ----------------------------
    Date::DATE_FORMATS[:default] = "%e/%B/%Y" 

    # DateTime / Time
    # ----------------------------
    # Time::DATE_FORMATS[:default] = "%d/%m/%Y %I:%M" 
    Time::DATE_FORMATS[:default] = "%d/%m/%Y %H:%M" 
  end
end
