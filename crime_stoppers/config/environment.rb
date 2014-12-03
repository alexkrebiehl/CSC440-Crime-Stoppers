# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
CrimeStoppers::Application.initialize!
ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'gmail.com',
  user_name:            ENV["EMAIL"],
  password:             ENV["PASSWORD"],
  authentication:       'plain',
  enable_starttls_auto: true  }
