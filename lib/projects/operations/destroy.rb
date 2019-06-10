module Projects
  module Operations
    class Destroy < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project',
        project_policy: 'projects.policy'
      ]

      def call(params:, user_id:, **)
        project = yield find_entity(params, project_repo, :id)
        yield project_policy.destroy?(project, user_id)
        project_repo.delete(project.id)

        Success()
      end
    end
  end
end
