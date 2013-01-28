ActionMailer::Base.smtp_settings = {
  :address              => "smtp.sendgrid.net",
  :port                 => 587,
  :domain               => AppConfig['sendgrid_domain'],
  :user_name            => AppConfig['sendgrid_username'],
  :password             => AppConfig['sendgrid_password'],
  :authentication       => "plain",
  :enable_starttls_auto => true
}

if  Rails.env.development? || Rails.env.staging?
  require 'development_mail_interceptor'
  ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor)
end