module ApiAuth
  class UserSerializer < TinySerializer
    attributes :id, :username, :created_at
  end
end
