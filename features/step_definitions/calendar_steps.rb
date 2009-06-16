Given /a post exists for (\w+)/ do |date_in_words|
  Factory(:snippet, :displayed_on => Date.today)
end

Then /I verify the page contains (\w+)'s date/ do |date_in_words|
  if date_in_words =~ /today/
    date = Date.today
  elsif date_in_words =~ /yesterday/
    unless Date.today.day == 1 # hack for month rollback
      date = Date.yesterday
    else
      date = Date.tomorrow
    end 
  end
  assert(@browser.contains_text(date.day.to_s))
  assert(@browser.contains_text(date.strftime("%m")))
end

Then /I click on (\w+)'s date/ do |date_in_words|
  if date_in_words =~ /today/
    date = Date.today
  elsif date_in_words =~ /yesterday/
    unless Date.today.day == 1 # hack for month rollback
      date = Date.yesterday
    else
      date = Date.tomorrow
    end 
  end
  @browser.link(:text, date.day.to_s).click
end
