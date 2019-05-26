Fabricator(:project) do
  title { sequence(:project_title) { |i| "Project Title #{i}" } }
end

Fabricator(:invalid_project, from: :project) do
  title { 'a' * 100 }
end
