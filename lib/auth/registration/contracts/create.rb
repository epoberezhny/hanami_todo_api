module Auth
  module Registration
    module Contracts
      Create = Dry::Validation.JSON(::Libs::Contract) do
        configure do
          option :user_repo

          def unique_username?(value)
            !user_repo.exists_with_username?(value)
          end
        end

        required(:username).filled(
          :str?,
          :unique_username?,
          min_size?: ::Auth::Constants::Username::MIN_SIZE,
          max_size?: ::Auth::Constants::Username::MAX_SIZE
        )
        required(:password).filled(
          :str?,
          min_size?: ::Auth::Constants::Password::MIN_SIZE,
          max_size?: ::Auth::Constants::Password::MAX_SIZE
        ).confirmation
      end
    end
  end
end
