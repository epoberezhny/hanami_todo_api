resource :registration, only: %i[create]
resource :session, only: %i[create show destroy]
resource :refresh, only: %i[create]
