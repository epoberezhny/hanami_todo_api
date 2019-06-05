module Auth
  module Registration
    module Operations
      class Create < ::Libs::Operation
        include ::Import[
          user_repo: 'repositories.user',
          contract: 'auth.registration.contracts.create'
        ]

        def call(params:, **)
          attrs = yield validate(params, contract, user_repo: user_repo)
          user = create_user(attrs)
          tokens = ::Auth::Utils::Token.generate_tokens(user)

          Success([user, tokens])
        end

        private

        def create_user(attrs)
          attrs[:password_hash] = ::Auth::Utils::Password.generate_password_hash(attrs[:password])
          user_repo.create(attrs)
        end
      end
    end
  end
end
