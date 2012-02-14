require 'rubygems'
# require 'dm-core'
# require 'dm-timestamps'
# require 'dm-validations'
# require 'dm-types'
# require 'dm-aggregates'
require 'haml'
require 'ostruct'

require 'sinatra' unless defined?(Sinatra)

configure do
  SiteConfig = OpenStruct.new(
                 :title => 'I Call BS',
                 :author => 'Collin Reisdorf',
                 :url_base => 'http://localhost:9393/'
               )

  # DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3:///#{File.expand_path(File.dirname(__FILE__))}/#{Sinatra::Base.environment}.db")

  # load models
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
  Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") { |lib| require File.basename(lib, '.*') }
  
end
