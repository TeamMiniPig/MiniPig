require "sinatra/activerecord/rake"
require "sinatra"

namespace :db do
  task :load_config do
    require "./controllers/application"
  end
end
