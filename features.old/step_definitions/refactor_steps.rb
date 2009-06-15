Then /I should see a refactor by "(.+)"/ do |login|
  response_body.should have_xpath("//*[text()=\"#{login}\"]")
end