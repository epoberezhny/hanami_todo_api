require 'dry/monads/result'
require 'dry/monads/do'

module Libs
  class Operation
    include Dry::Monads::Result::Mixin

    MATCHER = Dry::Matcher.new(
      success: Dry::Matcher::Case.new(
        match: :success.to_proc,
        resolve: :value!.to_proc
      ),
      failure: Dry::Matcher::Case.new(
        match: ->(result, status) { result.failure? && result.failure.status == status },
        resolve: ->(result) { result.failure.payload }
      )
    ).freeze

    def self.inherited(subclass)
      subclass.include Dry::Monads::Do.for(:call)
      subclass.include Dry::Matcher.for(:call, with: MATCHER)
    end

    def call(*)
      raise NotImplementedError
    end

    private

    def validate(contract, params)
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
