module Projects
  module Operations
    class Destroy < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project'
      ]

      def call(params:, **)
        project = yield find_entity(params, project_repo, :id)
        project_repo.delete(project.id)

        Success()
      end
    end
  end
end
