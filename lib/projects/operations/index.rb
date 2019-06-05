module Projects
  module Operations
    class Index < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project'
      ]

      def call(user_id:, **)
        Success(project_repo.by_user_id(user_id))
      end
    end
  end
end
