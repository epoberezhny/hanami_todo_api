module Tasks
  module Operations
    class Update < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project',
        task_repo: 'repositories.task',
        contract: 'tasks.contracts.update',
        project_policy: 'projects.policy'
      ]

      def call(params:, user_id:, **)
        project = yield find_entity(params, project_repo, :project_id)
        task = yield find_entity(params, task_repo, %i[project_id id], :find_by_project_id)

        yield project_policy.update?(project, user_id)

        attrs = yield validate(params, contract, task_repo: task_repo, project_id: params[:project_id])
        task_repo.transaction do
          update_task(project, task, attrs)
        end
      end

      private

      def update_task(project, task, attrs) # rubocop:disable Metrics/AbcSize
        if attrs[:position] && attrs[:position] != task.position
          task_repo.shift_left_from_by_project_id(project.id, task.position)
          task_repo.shift_right_from_by_project_id(project.id, attrs[:position])
        end

        Success(task_repo.update(task.id, attrs))
      end
    end
  end
end
