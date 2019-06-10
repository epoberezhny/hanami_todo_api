module ApiV1::Controllers::Comments
  class Index
    include ::ApiV1::Action
    include ::Import[
      operation: 'comments.operations.index'
    ]

    def call(params)
      operation.call(params: params, user_id: payload['user_id'], &handler)
    end

    private

    def serializer_class
      ::ApiV1::CommentSerializer
    end
  end
end
