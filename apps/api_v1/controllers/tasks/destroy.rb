module ApiV1::Controllers::Tasks
  class Destroy
    include ::ApiV1::Action
    include ::Import[
      operation: 'tasks.operations.destroy'
    ]

    def call(params)
      operation.call(params: params, user_id: payload['user_id'], &handler)
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
