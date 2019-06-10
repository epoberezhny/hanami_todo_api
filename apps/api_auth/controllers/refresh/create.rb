module ApiAuth::Controllers::Refresh
  class Create
    include ::ApiAuth::Action
    include ::Helpers::Authentication
    include ::Import[
      operation: 'auth.refresh.operations.create'
    ]

    before :authorize_by_refresh_header!

    def call(params)
      operation.call(params: params, payload: payload, refresh_token: found_token, &handler)
    end

    private

    def handler
      lambda do |m|
        m.success do |tokens|
          status 201, { data: tokens }.to_json
        end

        super.call(m)
      end
    end
  end
end
