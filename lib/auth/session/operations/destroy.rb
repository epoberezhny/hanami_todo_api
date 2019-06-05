module Auth
  module Session
    module Operations
      class Destroy < ::Libs::Operation
        def call(refresh_token:, **)
          Utils::Token.flush_session(refresh_token)

          Success()
        end
      end
    end
  end
end
