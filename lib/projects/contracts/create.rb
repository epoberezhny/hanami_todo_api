module Projects
  module Contracts
    Create = Dry::Validation.JSON do
      required(:title).filled(:str?, min_size?: 5, max_size?: 50)
    end
  end
end
