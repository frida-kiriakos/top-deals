require_relative 'spec_helper.rb'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TopDealsApp
  end

  def test_index
    get '/'
    assert last_response.ok?
    assert last_response.body.include?('Find Top Hotel Deals')
  end

  def test_search
    post '/search', destinationCity: 'New York', lengthOfStay: 3, minGuestRating: 4
    assert last_response.ok?
    assert last_response.body.include?('Perform a Different Search')
  end
end
