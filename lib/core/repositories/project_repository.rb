class ProjectRepository < Hanami::Repository
  def by_user_id(user_id)
    projects.where(user_id: user_id)
  end
end
