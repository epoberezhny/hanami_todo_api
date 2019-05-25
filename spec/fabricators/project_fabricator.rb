Fabricator(:project) do
  title { sequence(:project_title) { |i| "Project Title #{i}" } }
end
