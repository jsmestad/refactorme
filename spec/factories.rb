Factory.define :user do |u|
  u.sequence(:login) { |n| "johndoe#{n}" }
  u.sequence(:email) { |n| "person#{n}@example.com" }
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