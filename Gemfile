source 'http://rubygems.org'
source 'http://gems.github.com'

gem 'rails', '~> 3.0'
gem 'pg'

group :development do
  gem 'annotate', '~> 2.4'
end

group :development, :test do
  # Using Capybara head, following example at
  # http://opinionated-programmer.com/2011/02/capybara-and-selenium-with-rspec-and-rails-3/
  gem 'capybara', :git => 'git://github.com/jnicklas/capybara.git'
  gem 'ruby-debug'
  gem 'rspec-rails', '~> 2.5'
  gem 'factory_girl_rails'
end

group :test do
  gem 'darrell-database_cleaner', :require => 'database_cleaner'
end
