# frozen_string_literal: true

require 'mls_api/version'
require 'mls_api/mls_error'
require 'mls_api/connection'
require 'mls_api/resources/base'
require 'mls_api/resources/property'
require 'mls_api/query_builder/reso'
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

      Resources::Property.from_collection response.body
    end

    def property(listing_key)
      response = @connection.get("/Property('#{listing_key}')")

      Resources::Property.new response.body
    end
  end
end
