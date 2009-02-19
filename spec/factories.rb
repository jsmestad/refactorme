Factory.define :user do |u|
  u.login 'johndoe'
  u.email 'ben@ben.com'
  u.password "benrocks"
  u.password_confirmation "benrocks"
end

Factory.define :admin, :class => User, :parent => :user do |u|
  u.admin true
end

Factory.define :snippet do |s|
  s.title "Code Snippet"
  s.code "def hello_world; hello world; end;"
end