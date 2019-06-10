module Projects
  module Operations
    class Show < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project',
        project_policy: 'projects.policy'
      ]

      def call(params:, user_id:, **)
        project = yield find_entity(params, project_repo, :id)
        yield project_policy.show?(project, user_id)

        Success(project)
      end
    end
  end
end
