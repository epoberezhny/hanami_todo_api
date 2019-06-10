module Auth
  module Refresh
    module Operations
      class Create < ::Libs::Operation
        def call(refresh_token:, payload:, **)
          payload = payload.slice('user_id')
          tokens = ::Auth::Utils::Token.refresh_tokens(refresh_token, payload)

          Success(tokens)
        end
      end
    end
  end
end
