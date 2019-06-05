module ApiV1::Controllers::Projects
  class Show
    include ::ApiV1::Action
    include ::Import[
      operation: 'projects.operations.show'
    ]

    def call(params)
      operation.call(params: params, user_id: payload['user_id'], &handler)
    end

    private

    def serializer_class
      ::ApiV1::ProjectSerializer
    end
  end
end
