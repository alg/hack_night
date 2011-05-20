require 'omniauth/openid'
require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, AppConfig['twitter']['consumer_key'], AppConfig['twitter']['consumer_secret']
end

