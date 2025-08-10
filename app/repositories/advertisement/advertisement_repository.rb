module Repositories
  module Advertisement
    class AdvertisementRepository
      def list_advertisement
        ::Advertisement.all
      end
    end
  end
end
