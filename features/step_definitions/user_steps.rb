When /^I delete the (\d+)(?:st|nd|rd|th) user$/ do |pos|
  p User.count
  visit users_url
  within("table > tr:nth-child(#{pos.to_i+1})") do
    click_link "Delete"
  end
end

Then /^I should see the following users:$/ do |users|
  users.raw[1..-1].each_with_index do |row, i|
    row.each_with_index do |cell, j|
      response.should have_selector("table > tr:nth-child(#{i+2}) > td:nth-child(#{j+1})") { |td|
        td.inner_text.should == cell
      }
    end
  end
end
