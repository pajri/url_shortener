module Dtos
  module UrlRedirection
    class AnalyticsDto
      attr_accessor :advertisement_id, :ip_address, :user_agent, :referrer, :requested_url, :query_parameters, :session_id

      def initialize(ip_address:, user_agent:, referrer:, requested_url:, query_parameters:, session_id:)
        @ip_address = ip_address
        @user_agent = user_agent
        @referrer = referrer
        @requested_url = requested_url
        @query_parameters = query_parameters
        @session_id = session_id
      end
    end
  end
end
