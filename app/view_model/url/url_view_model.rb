module ViewModel
  module Url
    class UrlViewModel
      include ActiveModel::Model

      attr_accessor :advertisements, :url, :message, :success

      def initialize
        @advertisements = []
        @success = true
      end

      def persisted?
        false
      end
      
    end
  end
end