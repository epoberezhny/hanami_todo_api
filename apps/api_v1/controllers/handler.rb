module ApiV1
  module Controllers
    module DefaultHandler
      private

      def handler # rubocop:disable Metrics/MethodLength
        lambda do |m|
          m.success do |value|
            status 200, { data: serializer_class.new(value) }.to_json
          end

          m.failure :forbidden do
            self.status = 403
          end

          m.failure :not_found do
            self.status = 404
          end

          m.failure :unprocessable do |payload|
            status 422, payload.to_json
          end
        end
      end
    end
  end
end
