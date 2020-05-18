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
      @filters << 'City eq Lewisville'
      expect(query_builder.filters).to eq(@filters)
    end

    it 'sets eq coordinates' do
      query_builder.where_coordinates(36.091513, -115.10998)
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
end
