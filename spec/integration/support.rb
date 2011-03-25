RSpec.configure do |c|
  c.use_transactional_fixtures = false
  c.before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  c.after do
    DatabaseCleaner.clean
  end
end
