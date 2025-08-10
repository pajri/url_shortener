module Repositories
    module Url
        class UrlRepository
            def short_url_exist?(code)
                ::Url.exists?(short_url: code)
            end

            def save(url)
                new_url = ::Url.new
                new_url.long_url = url.long_url
                new_url.short_url = url.short_url
                new_url.expiration_date = url.expiration_date
                
                new_url.save
            end
        end
    end
end