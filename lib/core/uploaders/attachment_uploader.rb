class AttachmentUploader < Shrine
  plugin :upload_endpoint, max_size: 10 * 1024 * 1024 # 10 MB
  plugin :processing

  process(:store) do |io|
    io.download do |original|
      ImageProcessing::Vips.source(original).resize_to_limit!(500, 500)
    end
  end
end
