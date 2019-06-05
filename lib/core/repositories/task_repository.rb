class TaskRepository < Hanami::Repository
  def by_project_id(project_id)
    tasks.where(project_id: project_id)
  end

  def find_by_project_id(project_id, id)
    by_project_id(project_id).where(id: id).limit(1).one
  end

  def last_position_by_project_id(project_id)
    by_project_id(project_id).order { position.desc }.limit(1).select(:position).pluck(:position).first.to_i
  end

  def shift_left_from_by_project_id(project_id, from)
    by_project_id(project_id).where { position >= from }.update(Sequel.lit('position = position - 1'))
  end

  def shift_right_from_by_project_id(project_id, from)
    by_project_id(project_id).where { position >= from }.update(Sequel.lit('position = position + 1'))
  end

  def count_by_project_id(project_id)
    by_project_id(project_id).count
  end
end
