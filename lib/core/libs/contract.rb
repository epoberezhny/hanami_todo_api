module Libs
  class Contract < Dry::Validation::Schema
    configure do |config|
      config.messages = :i18n
    end
  end
end
