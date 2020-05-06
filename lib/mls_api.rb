# frozen_string_literal: true

require 'mls_api/version'
require 'mls_api/mls_error'
require 'mls_api/connection'
require 'faraday'
require 'json'

module MlsApi
  ###
  # @description: Class responsible to handle all API calls
  # @param server_token: Server token for access api
  # @param dataset: Dataset ID
  ###
  class Client
    def initialize(connection)
      @connection = connection || Connection.new().connection
    end
    
    def properties(params = {})
      response = @connection.get('/Property', params)

      get_body(response)
    end

    def property(listing_key)
      response = @connection.get("/Property('#{listing_key}')")

      get_body(response)
    end

    protected

      def get_body(response)
        JSON.parse(response.body)
      end
  end
end