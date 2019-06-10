module ApiAuth::Controllers::Session
  class Show
    include ::ApiAuth::Action
    include ::Helpers::Authentication
    include ::Import[
      operation: 'auth.session.operations.show'
    ]

    before :authorize_by_access_header!

    def call(params)
      operation.call(params: params, payload: payload, &handler)
    end

    private

    def serializer_class
      ::ApiAuth::UserSerializer
    end
  end
end
