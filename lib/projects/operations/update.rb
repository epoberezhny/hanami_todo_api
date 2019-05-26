module Projects
  module Operations
    class Update < ::Libs::Operation
      include ::Import[
        repository: 'repositories.project',
        contract: 'projects.contracts.update'
      ]

      def call(params:, **)
        project = yield find_project(params)
        attrs = yield validate(contract, params)
        project = yield persist(project, attrs)

        Success(project)
      end

      private

      def find_project(params)
        project = repository.find(params[:id])
        project ? Success(project) : Failure(::Libs::Error.new(status: :not_found))
      end

      def persist(project, attrs)
        Success(repository.update(project.id, attrs))
      end
    end
  end
end
