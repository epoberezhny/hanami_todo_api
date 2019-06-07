module Comments
  module Contracts
    Update = Dry::Validation.JSON(::Libs::Contract) do
      optional(:text).filled(
        :str?,
        min_size?: ::Comments::Constants::Text::MIN_SIZE,
        max_size?: ::Comments::Constants::Text::MAX_SIZE
      )
      optional(:attachment).filled
    end
  end
end
