require 'rubygems'
require 'sinatra'
require 'environment'
require 'linguistics'

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

helpers do
  # add helpers here
end

# root page
get '/' do
  haml :root
end

# flag the page and return a message WILL BE POST!!!
get '/flag' do
  # create makes the resource immediately need to get the post or get data and use it in place of the defaults
  @page = Page.create( :address => "http://paperclipped.com", :name => "Collin's Portfolio", :created_by => "Anony", :created_at => Time.now)
  
  @total = 3000
  Linguistics::use( :en, :installProxy => :en )
  @totalWord = (@total-1).numwords.capitalize
  
  inspect
  
  # haml :bullshit
end
