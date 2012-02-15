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
  
  AppConfig = YAML::load( File.open( "#{File.dirname(__FILE__)}/config/application.yml" ) )
  
  # Configure the CouchDB using the cloudant config
  # For more info, check http://addons.heroku.com/cloudant
  $COUCH = CouchRest.new( ENV['CLOUDANT_URL'] || AppConfig['COUCH_URL'] )
  $COUCH.default_database = 'bullshit'
  
  # You'll need to customize the following line. Replace the CONSUMER_KEY 
  #   and CONSUMER_SECRET with the values you got from Twitter 
  #   (https://dev.twitter.com/apps/new).
  $TWITTER_CONSUMER_KEY = ENV['TWITTER_CONSUMER_KEY'] || AppConfig['TWITTER_CONSUMER_KEY']
  $TWITTER_CONSUMER_SECRET = ENV['TWITTER_CONSUMER_SECRET'] || AppConfig['TWITTER_CONSUMER_SECRET']
  use OmniAuth::Strategies::Twitter, $TWITTER_CONSUMER_KEY, $TWITTER_CONSUMER_SECRET

  # load models & helpers
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
  Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") { |lib| require File.basename(lib, '.*') }
  
end
