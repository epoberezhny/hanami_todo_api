source 'https://rubygems.org'

ruby File.read(File.join(__dir__, '.ruby-version')).strip

gem 'rake'

# http
gem 'hanami', '~> 1.3'
gem 'puma'
gem 'puma-heroku'
gem 'rack-cors'

# persistence
gem 'hanami-model', '~> 1.3'
gem 'pg'

gem 'redis'

# JSON parsing/encoding
gem 'multi_json'
gem 'oj'

# serialization
gem 'tiny_serializer'

# dependency managment
gem 'dry-system'
gem 'dry-system-hanami', github: 'davydovanton/dry-system-hanami'

# business logic
gem 'dry-matcher'
gem 'dry-monads'

gem 'i18n'

# auth
gem 'bcrypt'
gem 'jwt_sessions'

# attachments
gem 'hanami-shrine', github: 'katafrakt/hanami-shrine'
gem 'image_processing'
gem 'shrine', '~> 2.19'
gem 'shrine-cloudinary', require: 'shrine/storage/cloudinary'

gem 'bootsnap'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  # gem 'shotgun', platforms: :ruby
end

group :test, :development do
  gem 'dotenv'

  gem 'byebug'

  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rspec', require: false

  gem 'hanami-fabrication'
end

group :test do
  gem 'rack-test'
  gem 'rspec'
  gem 'rspec_api_documentation'

  gem 'fuubar'
  gem 'rspec_junit_formatter'

  gem 'dry-validation-matchers'
  gem 'json_matchers', require: 'json_matchers/rspec'

  gem 'database_cleaner'
end
