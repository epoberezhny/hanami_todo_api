module Tasks
  module Operations
    class Index < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project',
        task_repo: 'repositories.task'
      ]

      def call(params:, **)
        project = yield find_entity(params, project_repo, :project_id)

        Success(task_repo.by_project_id(project.id))
      end
    end
  end
end
