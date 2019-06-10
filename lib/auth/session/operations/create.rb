module Auth
  module Session
    module Operations
      class Create < ::Libs::Operation
        include ::Import[
          user_repo: 'repositories.user',
        ]

        def call(params:, **)
          user = yield find_user(params)
          yield check_password(user, params)
          tokens = ::Auth::Utils::Token.generate_tokens(user)

          Success([user, tokens])
        end

        private

        def find_user(params)
          user = user_repo.find_by_username(params[:username])
          user ? Success(user) : Failure(::Libs::Error.new(status: :unauthorized))
        end

        def check_password(user, params)
          is_password_valid = ::Auth::Utils::Password.compare_password(params[:password], user.password_hash)
          is_password_valid ? Success() : Failure(::Libs::Error.new(status: :unauthorized))
        end
      end
    end
  end
end
