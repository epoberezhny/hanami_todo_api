Fabricator(:user) do
  username { sequence(:user_username) { |i| "username_#{i}" } }
end

Fabricator(:invalid_user, from: :task) do
  username { 'a' * 100 }
end
