class UserRepository < Hanami::Repository
  def exists_with_username?(username)
    by_username(username).exist?
  end

  def find_by_username(username)
    by_username(username).limit(1).one
  end

  private

  def by_username(username)
    users.where(username: username)
  end
end
