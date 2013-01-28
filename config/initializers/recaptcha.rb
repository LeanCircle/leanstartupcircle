Recaptcha.configure do |config|
  config.public_key  = AppConfig['recaptcha_public_key']
  config.private_key = AppConfig['recaptcha_private_key']
end