require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.app = Hanami.app
  config.format = [:open_api]
  config.configurations_dir = Hanami.root.join('spec', 'support', 'api')
  config.docs_dir = Hanami.root.join('public', 'swagger')
  config.request_headers_to_include = nil
  config.response_headers_to_include = %w[Location]
end
