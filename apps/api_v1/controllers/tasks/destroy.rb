module ApiV1::Controllers::Tasks
  class Destroy
    include ::ApiV1::Action
    include ::Import[
      operation: 'tasks.operations.destroy'
    ]

    def call(params)
      operation.call(params: params, &handler)
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

    def serializer_class
      ::ApiV1::TaskSerializer
    end
  end
end
