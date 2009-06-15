Given /^that an active snippet exists$/ do
  Given %{that a snippet exists}
  snippet = Snippet.first
  snippet.update_attribute(:displayed_on, Date.today)
end

Then /I should see a snippet for today/ do
  now = Date.today
  response_body.should have_xpath("//li")
end

Then /I should see "(\d+)" (\w+) snippet/ do |amount, type|
  if amount.to_i == 1
    if type == 'approved'
      response_body.should have_xpath("//tr[text()=\"1\"]")
    elsif type == 'pending'
      response_body.should have_xpath("//a[@class=\"approve\"]")
    end
  else
    raise "Only amount 1 supported until new webrat."
  end
end

Then /I should not see any snippets/ do
  response_body.should_not have_xpath("//tr")
end

When /I reload the page/ do
  reload
end


Given /that an approved snippet exists with the title "(.+)"/ do |title|
  snippet = Factory.create(:snippet, :title => title)
  snippet.approve!
end

When /the nightly rake task runs/ do
  Snippet.set_daily_snippet
end

Then /I should see a snippet with the title "(.+)"/ do |title|
  response_body.should have_xpath("//li/a")
end
