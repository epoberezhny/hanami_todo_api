module ApiV1::Controllers::Projects
  class Create
    include ::ApiV1::Action
    include ::Import[
      operation: 'projects.operations.create'
    ]

    def call(params)
      operation.call(params: params, &handler)
    end

    private

    def handler
      lambda do |m|
        m.success do |resource|
          status 201, { data: serializer_class.new(resource) }.to_json
          headers.merge!('Location' => routes.project_url(id: resource.id))
        end

        super.call(m)
      end
    end

    def serializer_class
      ::ApiV1::ProjectSerializer
    end
  end
end
