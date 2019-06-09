require_relative '../uploaders/attachment_uploader'

class Comment < Hanami::Entity
  include AttachmentUploader[:attachment]
end
