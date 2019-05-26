module Projects
  module Operations
    class Show < ::Libs::Operation
      include ::Import[
        repository: 'repositories.project'
      ]

      def call(params:, **)
        project = yield fetch_project(params)

        Success(project)
      end

      private

      def fetch_project(params)
        project = repository.find(params[:id])
        project ? Success(project) : Failure(::Libs::Error.new(status: :not_found))
      end
    end
  end
end
