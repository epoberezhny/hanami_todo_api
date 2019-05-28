module Tasks
  module Operations
    class Show < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project',
        task_repo: 'repositories.task'
      ]

      def call(params:, **)
        yield find_entity(params, project_repo, :project_id)
        task = yield find_entity(params, task_repo, :id)

        Success(task)
      end
    end
  end
end
