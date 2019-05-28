module ApiV1
  class TaskSerializer < TinySerializer
    attributes :id, :title, :done, :position, :deadline, :created_at
  end
end
