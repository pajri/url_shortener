# load view model
require_relative "../view_models/view_models/url/url_view_model"

# load services
require_relative "../services/services/advertisement/advertisement_service"
require_relative "../services/services/url/url_service"

# load repository
require_relative "../repositories/repositories/advertisement/advertisement_repository"
require_relative "../repositories/repositories/url/url_repository"

# load dto
require_relative "../dtos/dtos/url/url_dto"

class UrlsController < ApplicationController
  before_action :setup_services
  before_action :load_advertisements, only: [ :index, :create ]

  def index
  end

  def create
    # validate input
    @url  = Dtos::Url::UrlDto.new(long_url: url_param[:long_url])

    if !@url.valid? # invalid url
      @url_form.success = false
      @url_form.url = @url
      @url_form.message = "Error while shortening URL: "

      @url.errors.full_messages.each do |msg|
        puts "the message is"
        puts msg
      end

      render :index,  status: :unprocessable_content
      return
    end

    saved_url = @url_service.shorten_url(@url)

    host = request.base_url
    full_short_url  = @url_service.generate_full_short_url(host, saved_url.short_url)
    saved_url.short_url = full_short_url

    @url_form.success = true
    @url_form.url = saved_url
    @url_form.message = "Your short url: "


    render :index
  end
  # region private
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
    @url_form ||= ViewModels::Url::UrlViewModel.new
    @url_form.advertisements = @advertisement_service.list_advertisement || []
  end

  def setup_services
    @advertisement_repository = Repositories::Advertisement::AdvertisementRepository.new
    @advertisement_service = Services::Advertisement::AdvertisementService.new(repo: @advertisement_repository)

    @url_repository = Repositories::Url::UrlRepository.new
    @url_service = Services::Url::UrlService.new(repo: @url_repository)
  end
  # endregion
end
