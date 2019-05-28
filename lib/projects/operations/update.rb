module Projects
  module Operations
    class Update < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project',
        contract: 'projects.contracts.update'
      ]

      def call(params:, **)
        project = yield find_entity(params, project_repo, :id)
        attrs = yield validate(params, contract)

        Success(project_repo.update(project.id, attrs))
      end
    end
  end
end
