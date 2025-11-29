module ViewModels
  module UrlRedirection
    class UrlRedirectionViewModel
      attr_accessor :url, :message, :status, :advertisement

      def initialize(url: nil, message: nil, status: :success, advertisement: nil)
        @url = url
        @message = message
        @status = status
        @advertisement = advertisement
      end
    end
  end
end