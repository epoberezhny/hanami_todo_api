module ApiV1::Controllers::Tasks
  class Index
    include ::ApiV1::Action
    include ::Import[
      operation: 'tasks.operations.index'
    ]

    def call(params)
      operation.call(params: params, user_id: payload['user_id'], &handler)
    end

    private

    def serializer_class
      ::ApiV1::TaskSerializer
    end
  end
end
