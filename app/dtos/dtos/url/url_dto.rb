require "uri"

module Dtos
  module Url
    class UrlDto
      include ActiveModel::Model
      include ActiveModel::Validations

      URL_REGEX = /\A#{URI.regexp(%w[http https])}\z/

      attr_accessor :long_url, :short_url

      # VALIDATIONS
      validates :long_url,
        presence: true,
        length: { maximum: 255 },
        format: { with: URL_REGEX }

      validates :short_url,
        format: { with: URL_REGEX },
        allow_blank: true

      def initialize(long_url: nil, short_url: nil)
        # Normalize early
        @long_url = normalize(long_url)
        @short_url = normalize(short_url)
      end

      def persisted?
        false
      end

      private

      def normalize(value)
        v = value.to_s.strip
        v.presence  # converts "" to nil => presence: true will fail
      end
    end
  end
end
