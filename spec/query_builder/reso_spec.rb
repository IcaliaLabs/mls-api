# frozen_string_literal: true

RSpec.describe MlsApi::QueryBuilder::Reso do
  let(:query_builder) {described_class.new}
  # ?$filter=City eq 'Dallas'&$top=5
  context 'setting filters' do
    before do
      @filters = []
    end

    it 'sets eq price' do
      query_builder.where_price(50000.0)
      @filters << 'ListPrice eq 50000.0'
      expect(query_builder.filters).to eq(@filters)
    end

    it 'sets between prices' do
      query_builder.where_between_price(15000.0, 50000.0)
      @filters << 'ListPrice ge 15000.0 and ListPrice le 50000.0'
      expect(query_builder.filters).to eq(@filters)
    end

    it 'sets eq city' do
      query_builder.where_city('Lewisville')
      @filters << "City eq 'Lewisville'"
      expect(query_builder.filters).to eq(@filters)
    end

    it 'sets eq coordinates' do
      query_builder.where_coordinates(36.091513, -115.10998)
      @filters << 'geo.distance(Coordinates, POINT(-115.10998 36.091513)) lt 0.5'
      expect(query_builder.filters).to eq(@filters)
    end

    it 'sets multiple filters' do
      query_builder.where_price(50000.0)
      query_builder.where_city('Lewisville')
      query_builder.where_coordinates(36.091513, -115.10998)
      @filters << 'ListPrice eq 50000.0'
      @filters << "City eq 'Lewisville'"
      @filters << 'geo.distance(Coordinates, POINT(-115.10998 36.091513)) lt 0.5'
      expect(query_builder.filters).to eq(@filters)
    end
  end

  context 'setting params' do
    before do
      @params = {}
    end

    it 'sets top param' do
      query_builder.top(5)
      @params['$top'] = 5
      expect(query_builder.params).to eq(@params)
    end
  end

  context 'printing as query string' do
    it 'sets one filter' do
      query_builder.where_price(50000.0)
      price = 'ListPrice+eq+50000.0'
      expect(query_builder.to_query).to eq("?$filter=#{price}")
    end

    it 'sets multiple filters' do
      query_builder.where_price(50000.0)
      query_builder.where_city('Lewisville')
      query_builder.where_coordinates(36.091513, -115.10998)
      price = 'ListPrice+eq+50000.0'
      city = "City+eq+'Lewisville'"
      coords = 'geo.distance(Coordinates,+POINT(-115.10998+36.091513))+lt+0.5'
      query = "#{price}+and+#{city}+and+#{coords}"
      expect(query_builder.to_query).to eq("?$filter=#{query}")
    end

    it 'sets filters and params' do
      query_builder.top(5)
      query_builder.where_price(50000.0)
      query_builder.where_coordinates(36.091513, -115.10998)
      price = 'ListPrice+eq+50000.0'
      coords = 'geo.distance(Coordinates,+POINT(-115.10998+36.091513))+lt+0.5'
      query = "#{price}+and+#{coords}"
      expect(query_builder.to_query).to eq("?$top=5&$filter=#{query}")
    end
  end
end
