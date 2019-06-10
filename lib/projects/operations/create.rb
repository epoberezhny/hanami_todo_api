module Projects
  module Operations
    class Create < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project',
        contract: 'projects.contracts.create'
      ]

      def call(params:, user_id:, **)
        attrs = yield validate(params.to_h.merge(user_id: user_id), contract)

        Success(project_repo.create(attrs))
      end
    end
  end
end
