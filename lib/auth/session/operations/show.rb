module Auth
  module Session
    module Operations
      class Show < ::Libs::Operation
        include ::Import[
          user_repo: 'repositories.user',
        ]

        def call(payload:, **)
          user = yield find_entity(payload, user_repo, 'user_id')

          Success(user)
        end
      end
    end
  end
end
