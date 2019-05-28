require 'dry/system/container'
require 'dry/system/hanami'

Dry::System::Hanami::Resolver::CORE_FOLDER = 'core/'.freeze

# General container class for project dependencies
#
# {http://dry-rb.org/gems/dry-system/ Dry-system documentation}
class Container < Dry::System::Container
  extend Dry::System::Hanami::Resolver

  ITSELF_RESOLVER = :itself.to_proc.freeze

  use :env

  register_folder! 'core/repositories'

  %w[projects tasks].each do |domain|
    register_folder! "#{domain}/contracts", resolver: ITSELF_RESOLVER
    register_folder! "#{domain}/operations"
    register_file! "#{domain}/policy"
  end

  configure do |config|
    config.env = Hanami.env
  end
end
