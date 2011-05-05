require 'rubygems'
require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-aggregates'
require 'dm-types'
require 'dm-migrations'

  #load models
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
  Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") { |lib| require File.basename(lib, '.*') }


DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3:///#{File.expand_path(File.dirname(__FILE__))}/development.db")
DataMapper::Logger.new($stdout, :debug)

DataMapper.auto_migrate! #Destroy Destroy!
# DataMapper.auto_upgrade! #Don't Destroy.
DataMapper::Model.raise_on_save_failure = true
begin


Page.create :address => 'http://paperclipped.com', :name => 'Collins Portfolio', :created_by => 'Anony', :created_at =>Date.now
Flag.create :page_id => Page.last.id, :number => 1, :flagged_by => Page.last.created_by, :created_at =>Date.now

rescue
  puts 'something failed to save'
end

puts Page.all.each {|a|a.name}
