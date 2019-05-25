module ApiV1
  class ProjectSerializer < TinySerializer
    attributes :id, :title, :created_at
  end
end
