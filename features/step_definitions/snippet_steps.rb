Given /^that an active snippet exists$/ do
  Given %{that a snippet exists}
  snippet = Snippet.first
  snippet.update_attribute(:displayed_on, Date.today)
end

Then /I should see a snippet for today/ do
  now = Date.today
  response_body.should have_xpath("//*[@class=\"date\" and text()=\"#{now.strftime('%b %d')}\"]")
end