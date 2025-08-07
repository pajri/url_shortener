class UrlsController < ApplicationController
    def index
        #TODO:order by and show only not expired ad
        #TODO add is_display column
        @advertisements = Advertisement.all
        @url = Url.new
    end

    #TODO: add backend validation of the url
    def create 
        @url = Url.new(url_params)
        @url.short_url = generate_short_code
        @url.expiration_date = Date.today + 30

        if @url.save
            redirect_to urls_path, notice: "url successfully submitted"
        else
            render :index
        end
    end

    private
    def url_params
        params.require(:url).permit(:long_url)
    end
    
    def generate_short_code
        loop do
            code = SecureRandom.alphanumeric(8)
            break code unless Url.exists?(short_url: code) # break means returns value (code)
        end
    end
    
end
