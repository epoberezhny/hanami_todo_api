module Comments
  module Operations
    class Create < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project',
        task_repo: 'repositories.task',
        comment_repo: 'repositories.comment',
        contract: 'comments.contracts.create',
        comment_policy: 'comments.policy'
      ]

      def call(params:, user_id:, **)
        project = yield find_entity(params, project_repo, :project_id)
        task = yield find_entity(params, task_repo, %i[project_id task_id], :find_by_project_id)
        yield comment_policy.create?(project, user_id)
        attrs = yield validate(params, contract)
        attrs[:task_id] = task.id

        Success([
          project,
          comment_repo.create(::Comment.new(attrs))
        ])
      end
    end
  end
end
