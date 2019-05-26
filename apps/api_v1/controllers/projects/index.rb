module ApiV1::Controllers::Projects
  class Index
    include ::ApiV1::Action
    include ::Import[
      operation: 'projects.operations.index'
    ]

    def call(params)
      operation.call(params: params, &handler)
    end

    private

    def serializer_class
      ::ApiV1::ProjectSerializer
    end
  end
end
