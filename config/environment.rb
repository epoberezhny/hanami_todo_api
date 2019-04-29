require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require 'hanami/middleware/body_parser'
require_relative '../lib/hanami_todo_api'
require_relative '../apps/api_v1/application'

Hanami.configure do
  middleware.use Hanami::Middleware::BodyParser, :json

  mount ApiV1::Application, at: '/api/v1'

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/hanami_todo_api_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/hanami_todo_api_development'
    #    adapter :sql, 'mysql://localhost/hanami_todo_api_development'
    #
    adapter :sql, ENV.fetch('DATABASE_URL')

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root 'lib/hanami_todo_api/mailers'

    # See http://hanamirb.org/guides/mailers/delivery
    delivery :test
  end

  environment :development do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :debug
  end

  environment :production do
    logger level: :info, formatter: :json, filter: []

    mailer do
      delivery :smtp, address: ENV.fetch('SMTP_HOST'), port: ENV.fetch('SMTP_PORT')
    end
  end
end
