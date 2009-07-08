# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def current_user
    warden.user
  end
  
  def logged_in?
    warden.authenticated?
  end
end
