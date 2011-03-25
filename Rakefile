# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Dash::Application.load_tasks

namespace :models do
  desc "Annotate models using the annotate gem"
  task :annotate do
    `annotate -i -m -p after`
  end
end
