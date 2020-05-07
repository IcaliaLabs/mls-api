# frozen_string_literal: true

require 'faraday'

RSpec.describe MlsApi::Connection do
  let(:server_token)   { 'some_server_token' }
  let(:dataset) { 'some_dataset_id' }
  let(:mls_connection) { described_class.new(server_token, dataset) }

  it 'creates a new Faraday connection class' do
    expect(mls_connection.connection).not_to be nil
    expect(mls_connection.connection.kind_of?(Faraday.class)).not_to be nil
  end
end
