module Libs
  class Error
    attr_reader :status, :payload

    def initialize(status:, payload: nil)
      @status = status
      @payload = payload
    end
  end
end
