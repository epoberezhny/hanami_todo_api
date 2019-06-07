module Comments
  module Operations
    class Destroy < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project',
        task_repo: 'repositories.task',
        comment_repo: 'repositories.comment',
        comment_policy: 'comments.policy'
      ]

      def call(params:, user_id:, **)
        project = yield find_entity(params, project_repo, :project_id)
        task = yield find_entity(params, task_repo, %i[project_id task_id], :find_by_project_id)
        comment = yield find_entity(params, comment_repo, %i[task_id id], :find_by_task_id)

        yield comment_policy.destroy?(project, user_id)

        comment_repo.delete(comment.id)

        Success()
      end
    end
  end
end
