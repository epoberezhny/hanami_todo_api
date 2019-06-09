module ApiV1
  class CommentSerializer < TinySerializer
    attributes :id, :text, :attachment_url, :created_at
  end
end
