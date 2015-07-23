Rails.application.config.middleware.use OmniAuth::Builder do
  provider :stripe_connect, ENV['stripe_connect_client_id'], ENV['stripe_api_key'], :scope => 'read_write', :stripe_landing => 'login'
end