require 'uri'

module Dtos
  module Url
    class UrlDto 
      include ActiveModel::Validations

      attr_accessor :long_url, :short_url # create attributes with getter and setter

      validates :long_url, presence: true, length: { maximum: 255 }, format: { with: URI::DEFAULT_PARSER.make_regexp }
      validates :short_url, format: { with: URI::DEFAULT_PARSER.make_regexp }, allow_blank: true

      def initialize(long_url: nil, short_url: nil)
        @long_url = long_url
        @short_url = short_url
      end

      def persisted?
        false
      end
      
    end
  end
end
