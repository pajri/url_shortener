module Services
    module Advertisement
        class AdvertisementService
            def initialize(repo:)
                @repo = repo
            end

            def list_advertisement
                @repo.list_advertisement
            end
        end
        
    end
end