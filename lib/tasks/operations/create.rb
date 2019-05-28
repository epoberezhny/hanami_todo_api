module Tasks
  module Operations
    class Create < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project',
        task_repo: 'repositories.task',
        contract: 'tasks.contracts.create'
      ]

      def call(params:, **)
        project = yield find_entity(params, project_repo, :project_id)
        attrs = yield validate(params, contract)
        set_missing_attrs(attrs, project)

        Success(task_repo.create(attrs))
      end

      private

      def set_missing_attrs(attrs, project)
        last_position = task_repo.last_position_by_project_id(project.id)
        attrs[:project_id] = project.id
        attrs[:position] = last_position.next
      end
    end
  end
end
