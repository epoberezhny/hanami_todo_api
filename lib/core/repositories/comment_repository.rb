class CommentRepository < Hanami::Repository
  prepend AttachmentUploader.repository(:attachment)

  def by_task_id(task_id)
    comments.where(task_id: task_id)
  end

  def find_by_task_id(task_id, id)
    by_task_id(task_id).where(id: id).limit(1).one
  end
end
