module ApiV1::Controllers::Tasks
  class Update
    include ::ApiV1::Action
    include ::Import[
      operation: 'tasks.operations.update'
    ]

    def call(params)
      operation.call(params: params, &handler)
    end

    private

    def serializer_class
      ::ApiV1::TaskSerializer
    end
  end
end
