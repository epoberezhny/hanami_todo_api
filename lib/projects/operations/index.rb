module Projects
  module Operations
    class Index < ::Libs::Operation
      include ::Import[
        project_repo: 'repositories.project'
      ]

      def call(*)
        Success(project_repo.all)
      end
    end
  end
end
