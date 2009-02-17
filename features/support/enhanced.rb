Webrat.configure do |config|
  config.mode = :selenium
end
 
Before do
  # truncate your tables here, since you can't use transactional fixtures
end