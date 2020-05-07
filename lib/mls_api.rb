# frozen_string_literal: true

require 'mls_api/version'
require 'mls_api/mls_error'
require 'mls_api/connection'
require 'json'

module MlsApi
  ###
  # @description: Class responsible to handle all API calls
  # @param connection: Faraday
  ###
  class Client
    def initialize(connection)
      @connection = connection
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
