module ApiV1::Controllers::Projects
  class Destroy
    include ::ApiV1::Action
    include ::Import[
      operation: 'projects.operations.destroy'
    ]

    def call(params)
      operation.call(params: params, &handler)
    end

    private

    def handler
      lambda do |m|
        m.success do |resource|
          self.status = 204
        end

        super.call(m)
      end
    end

    def serializer_class
      ::ApiV1::ProjectSerializer
    end
  end
end
