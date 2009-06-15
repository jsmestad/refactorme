def path_to(page_name)
  case page_name
  
  when /the main page/i
    root_url
  when /the login page/i
    login_url
  when /the registration page/i
    new_user_url
  when /the manage users page/i
    users_url
  when /the snippet queue page/i
    snippets_url
  
  # Add more page name => path mappings here
  
  else
    raise "Can't find mapping from \"#{page_name}\" to a path."
  end
end