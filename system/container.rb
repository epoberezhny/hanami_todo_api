require 'dry/system/container'
require 'dry/system/hanami'

require_relative 'before_boot/shrine'
require_relative '../lib/core/libs/operation'
require_relative '../lib/core/libs/contract'

Dry::System::Hanami::Resolver::CORE_FOLDER = 'core/'.freeze

class Container < Dry::System::Container
  extend Dry::System::Hanami::Resolver

  ITSELF_RESOLVER = :itself.to_proc.freeze

  register_folder! 'core/repositories'

  %w[projects tasks auth/registration].each do |domain|
    register_folder! "#{domain}/contracts", resolver: ITSELF_RESOLVER
  end

  %w[projects tasks auth/registration auth/session auth/refresh].each do |domain|
    register_folder! "#{domain}/operations"
  end

  %w[projects].each do |domain|
    register_file! "#{domain}/policy"
  end
end
