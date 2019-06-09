Fabricator(:comment) do
  text { sequence(:comment_text) { |i| "Comment Text #{i}" } }
end

Fabricator(:invalid_comment, from: :comment) do
  text { 'a' * 100 }
end
