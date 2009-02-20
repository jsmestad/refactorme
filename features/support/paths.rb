def path_to(page_name)
  case page_name
  
  when /the main page/i
    root_url
  when /the login page/i
    login_url
  when / /i
  
  # Add more page name => path mappings here
  
  else
    raise "Can't find mapping from \"#{page_name}\" to a path."
  end
end