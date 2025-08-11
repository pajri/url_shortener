module Repositories
  module Advertisement
    class AdvertisementRepository
      # ===== START advertisement ======
      def list_advertisement
        ::Advertisement.all
      end

      def find_by(order:)
        ::Advertisement.find_by(order:order)
      end
      # ===== END url =====

      # ===== START ad analytics =====
      def save_analytics(analytics_dto:)
        analytics = ::AdvertisementAnalytic.new(
          advertisement_id: analytics_dto.advertisement_id,
          ip_address: analytics_dto.ip_address,
          user_agent: analytics_dto.user_agent,
          referrer: analytics_dto.referrer,
          requested_url: analytics_dto.requested_url,
          query_parameters: analytics_dto.query_parameters,
          session_id: analytics_dto.session_id
        )

        analytics.save
      end
      # ===== END ad analytics =====
      
      # ===== START ad pointer =====
      def current_pointer
        ::AdvertisementPointer.first
      end

      def update_pointer(id:, last_order:)
        ::AdvertisementPointer.update(id, last_order: last_order)
      end
      # ===== END ad pointer =====
    end
  end
end
