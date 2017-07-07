require 'sinatra/base'
require 'sinatra/twitter-bootstrap'
require 'pry'

# this class initializes our application for displaying deals
class TopDealsApp < Sinatra::Base
  register Sinatra::Twitter::Bootstrap::Assets

  get '/' do
    haml :index
  end
end

TopDealsApp.run!
