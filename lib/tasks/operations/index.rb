module Tasks
  module Operations
    class Index < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project',
        task_repo: 'repositories.task',
        task_policy: 'tasks.policy'
      ]

      def call(params:, user_id:, **)
        project = yield find_entity(params, project_repo, [:project_id])
        yield task_policy.index?(project, user_id)

        Success(task_repo.by_project_id(project.id))
      end
    end
  end
end
