# load view model
require Rails.root.join('app/view_model/url/url_view_model')

# load services
require Rails.root.join('app/services/advertisement/advertisement_service')
require Rails.root.join('app/services/url/url_service')

# load repository
require Rails.root.join('app/repositories/advertisement/advertisement_repository')
require Rails.root.join('app/repositories/url/url_repository')

# load dto
require Rails.root.join('app/dto/url/url_dto')

class UrlsController < ApplicationController
  before_action :load_advertisements, only: [:index, :create]

  def initialize
    @advertisement_repository = Repositories::Advertisement::AdvertisementRepository.new
    @advertisement_service = Services::Advertisement::AdvertisementService.new(repo: @advertisement_repository)

    @url_repository = Repositories::Url::UrlRepository.new
    @url_service = Services::Url::UrlService.new(repo: @url_repository)
  end

  def index
    puts 'index'
    #TODO:order by and show only not expired ad
    #TODO add is_display column
    @url_form = ViewModel::Url::UrlViewModel.new
  end
  
  def create 
    #validate input
    @url  = Dto::Url::UrlDto.new(long_url: url_param[:long_url])

    if !@url.valid? #invalid url
      @url_form.success = false
      @url_form.url = @url
      @url_form.message = "an error uccured during shortening url"
      render :index,  status: :unprocessable_content
      return
    end

    saved_url = @url_service.shorten_url(@url)
    @url_form.success = true
    @url_form.url = saved_url
    @url_form.message = "url shortened successfully"

    render :index
  end
  
  def preview
    @url = Url.find_by(short_url: params[:short_url])
    #TODO: get advertisement
    if @url.nil? #nil? is method name. the ruby convention '?' means the method return boolean
      render plain: "url not found", status: :not_found
    elsif @url.expiration_date.present? && @url.expiration_date < Date.today # present has more condition. not just nil, it can be empty as well. ti is from active records
      render plain: "this short url has expired", status: :gone
    else
      #TODO insert advertisement info to database
      render :preview
    end
  end
  
  def go
    @url = Url.find(params[:id])
    redirect_to @url.long_url, allow_other_host: true
  end
  
  #region private
  private
  def url_param
    params.require(:url_form).permit(:long_url)
  end
  
  def generate_short_code
    loop do
      code = SecureRandom.alphanumeric(8)
      break code unless Url.exists?(short_url: code) # break means returns value (code)
    end
  end

  def load_advertisements
    @url_form ||= ViewModel::Url::UrlViewModel.new
    @url_form.advertisements = @advertisement_service.list_advertisement || []
  end
  #endregion
  
end
