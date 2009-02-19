Given /^a user exists$/ do
  Factory.create(:user)
end
 
Given /^a user exists with email "(.+)"$/ do |email|
  user = Factory.build(:user, :login => nil, :password => nil, :password_confirmation => nil, :email => email)
  user.save(false)
end
 
Given /^a user exists with login "(.+)" and password "(.+)"$/ do |login, password|
  Factory(:user, :login => login, :password => password, :password_confirmation => password)
end
 
Given /^I am logged in$/ do
  Given %{a user exists}
  Given %{I visit the login page}
  Given %{I fill in "login" with "#{User.first.login}"}
  Given %{I fill in "password" with "#{User.first.password}"}
  Given %{I press "Login"}
end
 
Given /^I am logged in as "(.+)"$/ do |user|
  Given %{a user exists with login "#{user}" and password "thedude"}
  Given %{I go to /login}
  Given %{I fill in "login" with "#{user}"}
  Given %{I fill in "password" with "thedude"}
  Given %{I press "Login"}
end
