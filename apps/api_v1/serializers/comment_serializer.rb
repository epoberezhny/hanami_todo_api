module ApiV1
  class CommentSerializer < TinySerializer
    attributes :id, :text, :attachment, :created_at
  end
end
