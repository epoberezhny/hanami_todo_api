module Tasks
  module Contracts
    Create = Dry::Validation.JSON(::Libs::Contract) do
      required(:title).filled(
        :str?,
        min_size?: ::Tasks::Constants::Title::MIN_SIZE,
        max_size?: ::Tasks::Constants::Title::MAX_SIZE
      )
      optional(:deadline).maybe(:date_time?)
    end
  end
end
