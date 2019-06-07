module ApiV1::Controllers::Comments
  class Create
    include ::ApiV1::Action
    include ::Import[
      operation: 'comments.operations.create'
    ]

    def call(params)
      operation.call(params: params, user_id: payload['user_id'], &handler)
    end

    private

    def handler
      lambda do |m|
        m.success do |project, resource|
          status 201, { data: serializer_class.new(resource) }.to_json
          headers.merge!(
            'Location' => routes.project_task_comment_url(
              project_id: project.id, task_id: resource.task_id, id: resource.id
            )
          )
        end

        super.call(m)
      end
    end

    def serializer_class
      ::ApiV1::CommentSerializer
    end
  end
end
