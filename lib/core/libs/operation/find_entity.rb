module Libs
  class Operation
    class FindEntity
      extend Dry::Monads::Result::Mixin

      def self.call(params, repo, key = :id, method_name = :find)
        entity = repo.public_send(method_name, params[key])
        entity ? Success(entity) : Failure(::Libs::Error.new(status: :not_found))
      end
    end
  end
end
