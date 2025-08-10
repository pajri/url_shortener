require_relative '../../domains/url/url_domain'

module Services
    module Url
        class UrlService
            def initialize(repo:)
                @repo = repo
            end
            
            def shorten_url(url)
                short_url = generate_short_code
                
                url_domain = Domains::Url::UrlDomain.new(
                    long_url: url.long_url,
                    short_url: short_url
                )
                
                @repo.save(url_domain)

                return url_domain
            end
            
            private
            
            def generate_short_code
                loop do
                    code = SecureRandom.alphanumeric(8)
                    break code unless @repo.short_url_exist?(code) # break means returns value (code)
                end
            end
        end
    end
end