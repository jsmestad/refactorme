Given /^a user exists$/ do
  Factory.create(:user)
end
 
Given /^a user exists with login "(.+)" and password "(.+)"$/ do |login, password|
  Factory.create(:user, :login => login, :password => password, :password_confirmation => password)
end
 
Given /^I am logged in$/ do
  Given %{a user exists}
  Given %{I visit the login page}
  Given %{I fill in "Login" with "#{User.first.login}"}
  Given %{I fill in "Password" with "#{User.first.password}"}
  Given %{I press "Login"}
end
 
Given /^I am logged in as "(.+)"$/ do |user|
  Given %{a user exists with login "#{user}" and password "thedude"}
  Given %{I login as "#{user}"}
end

Given /^I login as "(.+)"$/ do |user|
  Given %{I visit the login page}
  Given %{I fill in "Login" with "#{user}"}
  Given %{I fill in "Password" with "thedude"}
  Given %{I press "Login"}
end

Given /^I am logged in as an admin$/ do
  user = Factory.create(:admin)
  Given %{I login as "#{user.login}"}
end