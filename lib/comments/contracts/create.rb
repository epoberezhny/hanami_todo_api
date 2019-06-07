module Comments
  module Contracts
    Create = Dry::Validation.JSON(::Libs::Contract) do
      optional(:text).filled(
        :str?,
        min_size?: ::Comments::Constants::Text::MIN_SIZE,
        max_size?: ::Comments::Constants::Text::MAX_SIZE
      )
      optional(:attachment).filled(:hash?)

      rule(at_least_one: %i[text attachment]) do |text, attachment|
        text.filled? | attachment.filled?
      end
    end
  end
end
