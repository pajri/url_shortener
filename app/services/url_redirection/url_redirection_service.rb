require 'thread'

require_relative '../../dtos/url_redirection/url_redirection_dto'
require_relative '../../dtos/url_redirection/analytics_dto'
require_relative '../../common/logger'

UrlRedirectionDto = ::Dtos::UrlRedirection::UrlRedirectionDto
POINTER_MUTEX = Mutex.new

module Services
  module UrlRedirection
    class UrlRedirectionService
      
      def initialize(url_repo:, ad_repo:)
        @url_repo = url_repo
        @ad_repo = ad_repo
      end

      def load_redirection_data(analytics_dto:, short_url:)
        url_redirection_dto = load_url(short_url: short_url)
        ad = load_advertisement
        url_redirection_dto.advertisement = ad
        
        analytics_dto.advertisement_id = ad.id
        @ad_repo.save_analytics(analytics_dto: analytics_dto)
        return url_redirection_dto
      end

      private

      def load_url(short_url:)
        url_redirection_dto = nil

        url = @url_repo.find_by(short_url: short_url)
        
        if url.nil?
          message = "url not found"
          url_redirection_dto = UrlRedirectionDto.new(url: url, message: message, status: :not_found)
        elsif url.expiration_date.present? && url.expiration_date < Date.today 
          message = "this short url has expired"
          url_redirection_dto = UrlRedirectionDto.new(url: url, message: message, status: :gone)
        else
          url_redirection_dto = UrlRedirectionDto.new(url: url)
        end
        
        return url_redirection_dto
      end

      def load_advertisement
        advertisement = nil
        
        POINTER_MUTEX.synchronize do
          current_pointer = @ad_repo.current_pointer
          last_order = current_pointer.last_order

          advertisement = @ad_repo.find_by(order: last_order)

          next_pointer = next_pointer(current: last_order)

          @ad_repo.update_pointer(id: current_pointer.id, last_order: next_pointer)
        end

        return advertisement
      end

      def next_pointer(current:)
        max_order = 10
        current = current + 1
        if current > max_order 
          current = 1
        end

        return current
      end
    end
  end
end