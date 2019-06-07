module Comments
  module Operations
    class Index < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project',
        task_repo: 'repositories.task',
        comment_repo: 'repositories.comment',
        comment_policy: 'comments.policy'
      ]

      def call(params:, user_id:, **)
        project = yield find_entity(params, project_repo, :project_id)
        task = yield find_entity(params, task_repo, %i[project_id task_id], :find_by_project_id)
        yield comment_policy.index?(project, user_id)

        Success(comment_repo.by_task_id(task.id))
      end
    end
  end
end
