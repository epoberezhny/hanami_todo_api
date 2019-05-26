module Projects
  module Operations
    class Index < ::Libs::Operation
      include ::Import[
        repository: 'repositories.project'
      ]

      def call(*)
        projects = yield fetch_projects

        Success(projects)
      end

      private

      def fetch_projects
        Success(repository.all)
      end
    end
  end
end
