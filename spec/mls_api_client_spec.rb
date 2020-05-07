# frozen_string_literal: true

require 'faraday'

RSpec.describe MlsApi::Client do
  let(:stubs)  { Faraday::Adapter::Test::Stubs.new }
  let(:conn)   { Faraday.new { |b| b.adapter(:test, stubs) } }
  let(:client) { described_class.new(conn) }

  it 'gets properties' do
    stubs.get('/Property') do |env|
      [
        200,
        { 'Content-Type': 'application/javascript' },
        File.open("#{Dir.pwd}/spec/fixtures/files/properties.txt").read
      ]
    end

    expect(client.properties.kind_of?(Array)).to be true
  end

  it 'gets property' do
    stubs.get("/Property('P_5af601c3fc76173b348291e9')") do |env|
      [
        200,
        { 'Content-Type': 'application/javascript' },
        File.open("#{Dir.pwd}/spec/fixtures/files/property.txt").read
      ]
    end

    property = client.property('P_5af601c3fc76173b348291e9')
    expect(property.ListingKey).to eq('P_5af601c3fc76173b348291e9')
  end
end
