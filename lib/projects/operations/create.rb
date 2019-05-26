module Projects
  module Operations
    class Create < ::Libs::Operation
      include ::Import[
        repository: 'repositories.project',
        contract: 'projects.contracts.create'
      ]

      def call(params:, **)
        params = yield validate(params)
        project = yield persist(params)

        Success(project)
      end

      private

      def validate(params)
        result = contract.call(params.to_h)

        if result.success?
          Success(result.output)
        else
          payload = { errors: result.errors }
          Failure(::Libs::Error.new(status: :unprocessable, payload: payload))
        end
      end

      def persist(params)
        Success(repository.create(params))
      end
    end
  end
end
