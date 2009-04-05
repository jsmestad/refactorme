class UserNotifier < ActionMailer::Base
  default_url_options[:host] = "refactorme.com"

  def activation_instructions(user)
    subject       "Activation Instructions"
    from          "RefactorMe Notifier <notifier@refactorme.com>"
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => register_url(user.perishable_token)
  end

  def activation_confirmation(user)
    subject       "Activation Complete"
    from          "RefactorMe Notifier <notifier@refactorme.com>"
    recipients    user.email
    sent_on       Time.now
    body          :root_url => root_url
  end

  def password_reset_instructions(user)
    subject       "Password Reset Instructions"
    from          "RefactorMe Notifier <notifier@refactorme.com>"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end
  
  def approved_snippet_notification(user, snippet)
    subject       "We have approved your snippet!"
    from          "RefactorMe Notifier <notifier@refactorme.com>"
    recipients    user.email
    sent_on       Time.now
    body          :snippet => snippet, :user => user
  end
  
end