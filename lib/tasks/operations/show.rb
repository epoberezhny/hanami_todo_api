module Tasks
  module Operations
    class Show < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project',
        task_repo: 'repositories.task',
        project_policy: 'projects.policy'
      ]

      def call(params:, user_id:, **)
        project = yield find_entity(params, project_repo, :project_id)
        task = yield find_entity(params, task_repo, %i[project_id id], :find_by_project_id)
        yield project_policy.show?(project, user_id)

        Success(task)
      end
    end
  end
end
