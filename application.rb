require 'bundler'
APP_ENV = (ENV["APP_ENV"] || :development).to_sym
Bundler.require(:default, APP_ENV)
ENV["DISABLE_DATABASE_ENVIRONMENT_CHECK"] ||= "true"

ActiveRecord::Base.configurations = {APP_ENV.to_s => {
  "adapter" => "sqlite3",
  "database" => "data/#{APP_ENV}.sqlite3",
  "pool" => 5,
}}
ActiveRecord::Base.establish_connection(APP_ENV)

ActiveRecord::Tasks::DatabaseTasks.tap do |config|
  config.root = Rake.application.original_dir
  config.env = APP_ENV.to_s
  config.db_dir = "data"
  config.migrations_paths = ["data/migrate"]
  config.database_configuration = ActiveRecord::Base.configurations
  config.seed_loader = Object.new.tap do |obj|
    def obj.load_seed
      load "#{ActiveRecord::Tasks::DatabaseTasks.db_dir}/seeds.rb"
    end
  end
end

class Widget < ActiveRecord::Base
  validates_presence_of :name
end
