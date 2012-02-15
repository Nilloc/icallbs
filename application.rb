require 'rubygems'
require 'sinatra'
require 'couchrest'
require 'couchrest_model'
require 'oa-oauth'
require 'environment'
require 'linguistics'

# Configure the CouchDB using the cloudant config
# For more info, check http://addons.heroku.com/cloudant
# set :cloudant_url, ENV['CLOUDANT_URL'] || 'http://localhost:5984'

$COUCH = CouchRest.new ENV["CLOUDANT_URL"]
$COUCH.default_database = "omniauth-for-sinatra"

class User < CouchRest::Model::Base
  use_database $COUCH.default_database

  property :uid
  property :name
  property :nickname
  property :profile_image
  timestamps!
  
  design do 
    view :by_uid
  end
end

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

# You'll need to customize the following line. Replace the CONSUMER_KEY 
#   and CONSUMER_SECRET with the values you got from Twitter 
#   (https://dev.twitter.com/apps/new).
use OmniAuth::Strategies::Twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']

enable :sessions

helpers do
  def current_user
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
  end
end

get '/' do
  @users = User.all;
  
  if current_user
    @user = current_user
    haml :home
  else
    # sign up/in page.
    haml :root
  end
end

get '/auth/:name/callback' do
  auth = request.env["omniauth.auth"]
  
  user = User.find_by_uid(auth["uid"]) || User.new(:uid => auth["uid"])
  user.nickname = auth["user_info"]["nickname"]
  user.profile_image = auth["user_info"]["image"]
  user.name = auth["screen_name"]
  user.save!

  session[:user_id] = user.id
  redirect '/'
end

get "/auth/failure" do
  params[:message]
end

get "/logout" do
  session[:user_id] = nil
  redirect '/'
end

# # root page
# get '/' do
#   haml :root
# end
# 
# # flag the page and return a message WILL BE POST!!!
# get '/flag' do
#   # create makes the resource immediately need to get the post or get data and use it in place of the defaults
#   # @page = Page.create( :address => "http://paperclipped.com", :name => "Collin's Portfolio", :created_by => "Anony", :created_at => Time.now)
#   
#   //@total = 3000
#   Linguistics::use( :en, :installProxy => :en )
#   @totalWord = (@total-1).numwords.capitalize
#   
#   inspect
#   
#   # haml :bullshit
# end
