require 'sinatra/base'
require 'sinatra/twitter-bootstrap'
require 'pry'
require 'rest-client'
require 'json'

# this class initializes our application for displaying deals
class TopDealsApp < Sinatra::Base
  register Sinatra::Twitter::Bootstrap::Assets
  API_URL = 'https://offersvc.expedia.com/offers/v2/getOffers'.freeze

  get '/' do
    haml :index
  end

  post '/search' do
    response = RestClient.get(API_URL,
                              params: search_params(request.params))
    parsed_response = JSON.parse(response, symbolize_names: true)
    hotels = parsed_response[:offers][:Hotel]
    @offers = filter_and_sort_results(hotels) unless hotels.nil?
    haml :search
  end

  helpers do
    def search_params(params)
      query_params = { scenario: 'deal-finder', page: 1, uid: 1, productType: 'Hotel' }
      params.map { |key, value| query_params[key] = value }
      query_params
    end

    def filter_and_sort_results(results)
      results.select  { |offer| offer[:hotelPricingInfo][:percentSavings] > 0 }
             .sort_by { |offer| offer[:hotelPricingInfo][:totalPriceValue] }
    end
  end
end

TopDealsApp.run!
