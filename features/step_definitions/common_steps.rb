Given /^that a (.*) exists$/ do |model|
  Factory.create(model.to_sym)
end