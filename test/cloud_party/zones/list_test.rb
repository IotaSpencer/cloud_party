require_relative '../../test-helper.rb'

class ListTest < MiniTest::Test

  def test_zones_list_response
    body = JSON.parse(File.read(File.expand_path('../../responses/zones/list.json')))
    CloudParty::Responses::Zones.new(:get, '/zones', body, @options)
  end
end