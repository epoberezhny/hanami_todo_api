module ApiAuth::Controllers::Registration
  class Create
    include ::ApiAuth::Action
    include ::Import[
      operation: 'auth.registration.operations.create'
    ]

    def call(params)
      operation.call(params: params, &handler)
    end

    private

    def handler
      lambda do |m|
        m.success do |resource, tokens|
          status 201, { data: serializer_class.new(resource), meta: tokens }.to_json
        end

        super.call(m)
      end
    end

    def serializer_class
      ::ApiAuth::UserSerializer
    end
  end
end
