module Helpers
  module Authentication
    HEADER_REGEXP = /\AHTTP_(.*)/.freeze

    def self.included(klass)
      klass.class_eval do
        include JWTSessions::Authorization
        include InstanceMethods

        handle_exception JWTSessions::Errors::Unauthorized => 401
      end
    end

    module InstanceMethods
      def request_headers
        @request_headers ||= request.env.each_with_object({}) do |(key, value), hash|
          hash[Regexp.last_match(1)] = value if key =~ HEADER_REGEXP
        end
      end

      def request_method
        request.request_method
      end
    end
  end
end
