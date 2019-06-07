# monkey patch
module Fabrication
  module Generator
    class Hanami
      protected

      def persist
        self._instance = repository.create(_instance)
      end
    end
  end
end
