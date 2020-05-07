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

    expect(client.properties.key?('value')).to be true
    expect(client.properties['value'].kind_of?(Array)).to be true
  end
end
