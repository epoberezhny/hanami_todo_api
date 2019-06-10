Fabricator(:task) do
  title { sequence(:task_title) { |i| "Task Title #{i}" } }
  position { sequence(:task_position) }
end

Fabricator(:invalid_task, from: :task) do
  title { 'a' * 100 }
end
