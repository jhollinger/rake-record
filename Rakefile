require 'json'
require 'bundler/setup'
load 'active_record/railties/databases.rake'

namespace :db do
  task :environment do
    require_relative 'application'
  end
end

namespace :widgets do
  desc "Query all widgets"
  task :query => 'db:environment' do
    widgets = Widget.order('name').to_a
    puts widgets.map(&:as_json).to_json
  end

  desc "Fetch a single widget"
  task :fetch, [:id] => 'db:environment' do |_, args|
    widget = Widget.find(args[:id])
    puts widget.to_json
  end

  desc "Create a new widget"
  task :create, [:name] => 'db:environment' do |_, args|
    widget = Widget.new(name: args[:name])
    if widget.save
      puts widget.to_json
    else
      abort({errors: widget.errors.full_message}.to_json)
    end
  end

  desc "Update a widget"
  task :update, [:id, :name] => 'db:environment' do |_, args|
    widget = Widget.where(id: args[:id]).first
    abort({errors: ["Widget '#{args[:id]}' not found"]}.to_json) if widget.nil?

    if widget.update_attributes({name: args[:name]})
      puts widget.to_json
    else
      abort({errors: widget.errors.full_message}.to_json)
    end
  end
end
