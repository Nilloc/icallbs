require 'rubygems'
require 'sinatra'
require 'linguistics'
require './environment'

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

enable :sessions

helpers Sinatra::Partials

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
