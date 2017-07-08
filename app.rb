require 'sinatra/base'
require 'sinatra/twitter-bootstrap'
require 'json'
require_relative 'app_helpers'

# this class initializes our application for displaying deals
class TopDealsApp < Sinatra::Base
  ENV['RACK_ENV'] ||= 'development'

  helpers AppHelpers

  register Sinatra::Twitter::Bootstrap::Assets

  get '/' do
    haml :index
  end

  post '/search' do
    response = hotel_offers_api(request.params)
    parsed_response = JSON.parse(response, symbolize_names: true)
    hotels = parsed_response[:offers][:Hotel]
    @offers = filter_and_sort_results(hotels) unless hotels.nil?
    haml :search
  end
end
