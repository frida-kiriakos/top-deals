require_relative 'spec_helper.rb'
require_relative '../app_helpers'

class AppHelpersTest < Minitest::Test
  include AppHelpers

  def test_hotel_offers_api
    params = { destinationCity: 'New York', lengthOfStay: 4 }
    response = hotel_offers_api(params)
    parsed_response = JSON.parse(response, symbolize_names: true)
    assert(response.code == 200)
    assert(parsed_response[:offers][:Hotel].count > 0)
  end

  def test_search_params
    default_params = { scenario: 'deal-finder', page: 1, uid: 1, productType: 'Hotel' }
    params = { destinationCity: 'Amman', lengthOfStay: 4 }
    assert(search_params(params) == default_params.merge(params))
  end

  def test_filter_and_sort_results
    no_deal_hotel = { hotelPricingInfo: { percentSavings: 0.0 } }
    hotel_deal1 = { hotelPricingInfo: { percentSavings: 20.0, totalPriceValue: 300.0 } }
    hotel_deal2 = { hotelPricingInfo: { percentSavings: 20.0, totalPriceValue: 255.5 } }

    results = [no_deal_hotel, hotel_deal1, hotel_deal2]

    assert(filter_and_sort_results(results) == [hotel_deal2, hotel_deal1])
  end

  def test_decode_url
    url = 'http%3A%2F%2Fdeals.expedia.com%2Fbeta%2Fhotel_redirect%3FhotelId%3D38762'
    assert(decode_url(url) == 'http://deals.expedia.com/beta/hotel_redirect?hotelId=38762')
  end
end
