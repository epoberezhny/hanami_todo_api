module Projects
  module Contracts
    Create = Dry::Validation.JSON do
      required(:title).filled(
        :str?,
        min_size?: ::Projects::Constants::Title::MIN_SIZE,
        max_size?: ::Projects::Constants::Title::MAX_SIZE
      )
      required(:user_id).filled(:int?)
    end
  end
end
