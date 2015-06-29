Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :facebook, Rails.application.secrets.facebook_app_id, Rails.application.secrets.facebook_app_secret, scope: 'public_profile'

  puts "Here is debugging: Facebook ID: #{Rails.application.secrets.facebook_app_id}, Secret: #{Rails.application.secrets.facebook_app_secret}"
  
  provider :facebook, Rails.application.secrets.facebook_app_id, Rails.application.secrets.facebook_app_secret, { 
    client_options: { ssl: { 
        ca_file: '/usr/lib/ssl/certs/ca-certificates.crt',
        ca_path: "/etc/ssl/certs"
    }}
  }
end
