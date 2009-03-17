Factory.define :user do |u|
  u.sequence(:login) { |n| "johndoe#{n}" }
  u.sequence(:email) { |n| "person#{n}@example.com" }
  u.password "benrocks"
  u.password_confirmation "benrocks"
  u.active true
end

Factory.define :admin, :class => User, :parent => :user do |u|
  u.admin true
end

Factory.define :snippet do |s|
  s.title "Code Snippet"
  s.code "def hello_world; hello world; end;"

  # need context, but m.context would call the rspec method
  s.add_attribute :context, "some context"
  s.gist_id 7890
end

Factory.define :gist_snippet, :class => Snippet, :parent => :snippet do |s|
  s.github_url "http://gist.github.com/4277"
end

Factory.define :refactor do |r|
  r.association :user, :factory => :user
  r.association :snippet, :factory => :snippet
  r.gist_id 4567
end

Factory.define :vote do |v|
  v.association :user, :factory => :user
  v.association :refactor, :factory => :refactor
  v.score 1
end