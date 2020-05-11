# frozen_string_literal: true
require 'json'

module MlsApi
  module Resources
    ###
    # @description: Class responsible to parse json response
    # @param body: Faraday response body
    ###
    class Base < OpenStruct
      def initialize(body)
        @body = body.kind_of?(Hash) ? body : JSON.parse(body)
        super(@body)
      end

      def key?(key)
        @table.key?(key)
      end

      def self.from_collection(body)
        json = JSON.parse(body)
        json['value'].map{|property| self.new(property) }
      end
    end
  end
end
