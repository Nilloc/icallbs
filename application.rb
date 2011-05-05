require 'rubygems'
require 'sinatra'
require 'environment'

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

helpers do
  # add your helpers here
end

# root page
get '/' do
  haml :root
end

# flag the page and return a message
get '/flag' do
  # create makes the resource immediately need to get the post or get data and use it in place of the defaults
  @page = Page.create( :address => "http://paperclipped.com", :name => "Collin's Portfolio", :created_by => "Anony", :created_at => Time.now)
  '<h3>Page was successfully saved.</h3>'
end
