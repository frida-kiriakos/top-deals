require 'rest-client'

# this module consists of helper methods required by the application
module AppHelpers
  API_URL = 'https://offersvc.expedia.com/offers/v2/getOffers'.freeze

  def hotel_offers_api(params)
    RestClient.get(API_URL, params: search_params(params))
  end

  def search_params(params)
    query_params = { scenario: 'deal-finder', page: 1, uid: 1, productType: 'Hotel' }
    params.map { |key, value| query_params[key] = value }
    query_params
  end

  def filter_and_sort_results(results)
    results.select  { |offer| offer[:hotelPricingInfo][:percentSavings] > 0 }
           .sort_by { |offer| offer[:hotelPricingInfo][:totalPriceValue] }
  end

  def decode_url(url)
    URI.decode_www_form(url).flatten.first
  end
end
