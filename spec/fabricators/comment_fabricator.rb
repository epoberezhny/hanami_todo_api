Fabricator(:comment) do
  text { sequence(:comment_text) { |i| "Comment Text #{i}" } }
end
