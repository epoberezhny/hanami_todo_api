module ApiAuth::Controllers::Session
  class Destroy
    include ::ApiAuth::Action
    include ::Helpers::Authentication
    include ::Import[
      operation: 'auth.session.operations.destroy'
    ]

    before :authorize_by_refresh_header!

    def call(params)
      operation.call(params: params, refresh_token: found_token, &handler)
    end

    private

    def handler
      lambda do |m|
        m.success do
          self.status = 204
        end

        super.call(m)
      end
    end
  end
end
