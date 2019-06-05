JWTSessions.encryption_key = ENV['JWT_ENCRYPTION_KEY']

JWTSessions.access_header = 'AUTHORIZATION'
JWTSessions.refresh_header = 'X_REFRESH_TOKEN'

JWTSessions.token_store = :memory if Hanami.env == 'test'
