module Tasks
  module Contracts
    Update = Dry::Validation.JSON(::Libs::Contract) do
      configure do
        option :task_repo
        option :project_id

        def valid_position?(value)
          value <= task_repo.count_by_project_id(project_id)
        end
      end

      optional(:title).filled(
        :str?,
        min_size?: ::Tasks::Constants::Title::MIN_SIZE,
        max_size?: ::Tasks::Constants::Title::MAX_SIZE
      )
      optional(:done).filled(:bool?)
      optional(:position).filled(:int?, :valid_position?, gt?: 0)
      optional(:deadline).maybe(:date_time?)
    end
  end
end
