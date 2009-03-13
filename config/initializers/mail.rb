
ActionMailer::Base.smtp_settings = {
  :address => 'smtp.gmail.com',
  :port => 587,
  :authentication => :plain,
  :user_name => 'notifier@refactorme.com',
  :password => '94T252'
}

# You can use these settings to create URLS with the rails helpers in your mails
# ActionMailer::Base.default_url_options[:host] = 'localhost'
# ActionMailer::Base.default_url_options[:port] = '3000'