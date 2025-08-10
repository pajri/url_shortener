require 'uri'

module Dto
  module Url
    class UrlDto 
      include ActiveModel::Model
      include ActiveModel::Validations

      attr_accessor :long_url, :short_url # create attributes with getter and setter

      validates :long_url, presence: true
      validate  :long_url_format

      def initialize(long_url: nil, short_url: nil)
        @long_url = long_url
        @short_url = short_url
      end

      def long_url_format
        return if long_url.blank?
        if !valid_url?(long_url)
          errors.add(:long_url, "‘#{long_url}’ is invalid")
        end
      end

      def short_url_format
        if !valid_url?(short_url)
          errors.add(:short_url, "‘#{short_url}’ is invalid")
        end
      end

      def valid_url?(url)
        uri = URI.parse(url)
        uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
      rescue URI::InvalidURIError => e
        false
      end

      def persisted?
        false
      end
      
    end
  end
end
