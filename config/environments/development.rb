Rails.application.configure do
 config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.raise_runtime_errors = true
  

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { :host => '192.168.16.4'}
  config.action_mailer.perform_deliveries = true
  config.action_mailer.default_options = {from: 'sentry@caffenero.com'}


  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
   :address        => 'mail.caffenero.com',
   :domain         => 'nero.local',
   :port           => '25',
   :openssl_verify_mode => 'none'
  }
end
