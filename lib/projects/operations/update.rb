module Projects
  module Operations
    class Update < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project',
        contract: 'projects.contracts.update',
        project_policy: 'projects.policy'
      ]

      def call(params:, user_id:, **)
        project = yield find_entity(params, project_repo, :id)
        attrs = yield validate(params, contract)
        yield project_policy.update?(project, user_id)

        Success(project_repo.update(project.id, attrs))
      end
    end
  end
end
