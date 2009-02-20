Given /^that a (.*) exists$/ do |model|
  Factory.create(model.to_sym)
end

Given /^that (\d+) (.*)s exist$/ do |count, model|
  count.to_i.times { Factory.create(model.to_sym) }
end