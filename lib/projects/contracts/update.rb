module Projects
  module Contracts
    Update = Dry::Validation.JSON do
      optional(:title).filled(
        :str?,
        min_size?: ::Projects::Constants::Title::MIN_SIZE,
        max_size?: ::Projects::Constants::Title::MAX_SIZE
      )
    end
  end
end
