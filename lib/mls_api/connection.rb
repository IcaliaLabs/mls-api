# frozen_string_literal: true

require 'faraday'

module MlsApi
  ###
  # @description: Class responsible to handle all API calls
  # @param server_token: Server token for access api
  # @param dataset: Dataset ID
  ###
  class Connection
    URL = 'https://api.bridgedataoutput.com/api/v2/OData/%s'

    attr_reader :connection

    def initialize(server_token, dataset)
      @server_token = server_token
      @dataset = dataset
      set_connection
    end
    
    protected
    
    def set_connection
      @connection = Faraday.new(
        url: base_url,
        headers: {
          'Content-Type' => 'application/json',
          'Authorization': "Bearer #{@server_token}"
        }
      )
    end

      def base_url
        sprintf(URL, @dataset)
      end
  end
end
