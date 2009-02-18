# This will guess the User class
Factory.define :user do |u|
  u.login 'johndoe'
  u.email 'ben@ben.com'
  u.password "benrocks"
  u.password_confirmation "benrocks"
end

# This will use the User class (Admin would have been guessed)
Factory.define :admin, :class => User do |u|
  u.first_name 'Admin'
  u.last_name  'User'
  u.admin true
end