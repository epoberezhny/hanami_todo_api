module Tasks
  module Operations
    class Destroy < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project',
        task_repo: 'repositories.task'
      ]

      def call(params:, **)
        project = yield find_entity(params, project_repo, :project_id)
        task = yield find_entity(params, task_repo, :id)
        task_repo.transaction do
          destroy_task(project, task)
        end

        Success()
      end

      private

      def destroy_task(project, task)
        task_repo.shift_left_from_by_project_id(project.id, task.position)
        task_repo.delete(task.id)
      end
    end
  end
end
