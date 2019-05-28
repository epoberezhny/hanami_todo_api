module Projects
  module Operations
    class Show < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project'
      ]

      def call(params:, **)
        project = yield find_entity(params, project_repo, :id)

        Success(project)
      end
    end
  end
end
