module Libs
  class Operation
    class Validate
      extend Dry::Monads::Result::Mixin

      def self.call(params, contract, with = {})
        contract = contract.with(with) unless with.empty?
        result = contract.call(params.to_h)

        if result.success?
          Success(result.output)
        else
          payload = { errors: result.errors }
          Failure(::Libs::Error.new(status: :unprocessable, payload: payload))
        end
      end
    end
  end
end
