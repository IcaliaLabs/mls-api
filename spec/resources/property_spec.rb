# frozen_string_literal: true

RSpec.describe MlsApi::Resources::Property do
  let(:property) {
    File.open("#{Dir.pwd}/spec/fixtures/files/property.txt").read
  }
  let(:properties) {
    File.open("#{Dir.pwd}/spec/fixtures/files/properties.txt").read
  }

  it 'parse property' do
    property_intance = described_class.new(property)

    expect(property_intance.key?(:ListingKey)).to be true
    expect(property_intance.ListingKey).to eq('P_5af601c3fc76173b348291e9')
  end

  it 'parse properties' do
    property_collection = described_class.from_collection(properties)
    first_property = property_collection.first

    expect(property_collection.kind_of?(Array)).to be true
    expect(first_property.kind_of?(described_class)).to be true
    expect(first_property.key?(:ListingKey)).to be true
    expect(first_property.ListingKey).to eq('P_5af601c3fc76173b348291e9')
  end
end
