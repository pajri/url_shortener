# load repo
require_relative '../repositories/url/url_repository'
require_relative '../repositories/advertisement/advertisement_repository'

# load service
require_relative '../services/url/url_service'
require_relative '../services/url_redirection/url_redirection_service'

# load dto
require_relative '../view_models/url_redirection/url_redirection_view_model'


UrlRedirectionViewModel = ::ViewModels::UrlRedirection::UrlRedirectionViewModel
class UrlRedirectionController < ApplicationController
  def initialize
    @url_repository = Repositories::Url::UrlRepository.new
    @ad_repo = Repositories::Advertisement::AdvertisementRepository.new
    
    @redirection_service = Services::UrlRedirection::UrlRedirectionService.new(
      url_repo: @url_repository,
      ad_repo: @ad_repo
    )

    @url_service = Services::Url::UrlService.new(repo: @url_repository)
  end

  def index
    analytics_dto = Dtos::UrlRedirection::AnalyticsDto.new(
      ip_address: request.remote_ip,
      user_agent: request.user_agent,
      referrer: request.referrer,
      requested_url: request.url,
      query_parameters: request.query_parameters,
      session_id: request.session.id
    )
    short_url = params[:short_url]

    url_redirection_dto = @redirection_service.load_redirection_data(
      analytics_dto: analytics_dto,
      short_url: short_url
    )

    @url_redirection_view_model = UrlRedirectionViewModel.new(
      url: url_redirection_dto.url,
      message: url_redirection_dto.message,
      status: url_redirection_dto.status,
      advertisement: url_redirection_dto.advertisement
    )

    render :index
  end
  
  def go
    @url = @url_service.find(id: params[:id])
    redirect_to @url.long_url, allow_other_host: true
  end
end
