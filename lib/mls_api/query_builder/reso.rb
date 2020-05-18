# frozen_string_literal: true
require 'json'
require 'uri'

module MlsApi
  module QueryBuilder
    ###
    # @description: Class responsible to parse json as query string
    # @param body: Faraday response body
    ###
    class Reso
      attr_reader :params, :filters

      def initialize
        @params = {}
        @filters = []
      end

      def where_price(amount)
        equal_query('ListPrice', amount)
        self
      end

      def where_between_price(lower_amount, greather_amount)
        
        between_query('ListPrice', lower_amount, greather_amount)
        self
      end

      def top(limit)
        @params['$top'] = limit
        self
      end

      def where_city(name)
        equal_query('City', "'#{name}'")
        self
      end

      def where_coordinates(latitude, longitude, radius = 0.5)
        @filters << "geo.distance(Coordinates, POINT(#{longitude} #{latitude})) lt #{radius}"
        self
      end

      def to_hash
        @params['$filter'] = @filters.join(' and ')
        @params
      end


      def to_query
        query = URI.encode_www_form(to_hash)
        "?#{URI.decode(query)}"
      end

      private

      def equal_query(key, value)
        @filters << "#{key} eq #{value}"
      end

      def between_query(key, lower_value, greather_value)
        query = "#{key} ge #{lower_value} and #{key} le #{greather_value}"
        @filters << query
      end
    end
  end
end
