module Libs
  class Operation
    class FindEntity
      extend Dry::Monads::Result::Mixin

      def self.call(params, repo, key)
        entity = repo.find(params[key])
        entity ? Success(entity) : Failure(::Libs::Error.new(status: :not_found))
      end
    end
  end
end
