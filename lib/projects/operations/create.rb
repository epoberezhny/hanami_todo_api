module Projects
  module Operations
    class Create < ::Libs::Operation
      include ::Import[
        repository: 'repositories.project',
        contract: 'projects.contracts.create'
      ]

      def call(params:, **)
        attrs = yield validate(contract, params)
        project = yield persist(attrs)

        Success(project)
      end

      private

      def persist(attrs)
        Success(repository.create(attrs))
      end
    end
  end
end
