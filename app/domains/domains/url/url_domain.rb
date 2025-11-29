module Domains
    module Url
        class UrlDomain
            attr_accessor :long_url, :short_url
            attr_reader :expiration_date

            def initialize(long_url: , short_url: )
                @long_url = long_url
                @short_url = short_url 
                @expiration_date = default_expiration_date
            end

            private

            def default_expiration_date
                @expiration_date = Date.today + 30
            end
        end
    end
end