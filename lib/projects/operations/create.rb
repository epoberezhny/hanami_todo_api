module Projects
  module Operations
    class Create < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project',
        contract: 'projects.contracts.create'
      ]

      def call(params:, **)
        attrs = yield validate(params, contract)

        Success(project_repo.create(attrs))
      end
    end
  end
end
