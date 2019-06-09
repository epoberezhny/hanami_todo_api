module Comments
  module Operations
    class Update < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project',
        task_repo: 'repositories.task',
        comment_repo: 'repositories.comment',
        contract: 'comments.contracts.update',
        comment_policy: 'comments.policy'
      ]

      def call(params:, user_id:, **) # rubocop:disable Metrics/AbcSize
        project = yield find_entity(params, project_repo, :project_id)
        yield find_entity(params, task_repo, %i[project_id task_id], :find_by_project_id)
        comment = yield find_entity(params, comment_repo, %i[task_id id], :find_by_task_id)

        yield comment_policy.update?(project, user_id)

        attrs = yield validate(params, contract)

        Success(
          comment_repo.update(comment.id, ::Comment.new(attrs))
        )
      end
    end
  end
end
