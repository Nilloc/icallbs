require 'rubygems'
require 'couchrest'
require 'couchrest_model'
require 'haml'
require 'yaml'
require 'oa-oauth'
require 'ostruct'

require 'sinatra' unless defined?(Sinatra)

configure do
  SiteConfig = OpenStruct.new(
                   :title => 'I Call BS',
                   :author => 'Collin Reisdorf',
                   :url_base => 'http://icallbs.heroku.com/'
                 )
  
  AppConfig = (ENV['CLOUDANT_URL']) ? nil : YAML::load( File.open( "#{File.dirname(__FILE__)}/config/application.yml" ) )
  
  # couch db connection
  $COUCH = CouchRest.new( ENV['CLOUDANT_URL'] || AppConfig['CLOUDANT_URL'] )
  $COUCH.default_database = 'bullshit'
  
  # twitter api setup
  $TWITTER_CONSUMER_KEY = ENV['TWITTER_CONSUMER_KEY'] || AppConfig['TWITTER_CONSUMER_KEY']
  $TWITTER_CONSUMER_SECRET = ENV['TWITTER_CONSUMER_SECRET'] || AppConfig['TWITTER_CONSUMER_SECRET']
  use OmniAuth::Strategies::Twitter, $TWITTER_CONSUMER_KEY, $TWITTER_CONSUMER_SECRET

  # load models & helpers
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
  Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") { |lib| require File.basename(lib, '.*') }
  
end
