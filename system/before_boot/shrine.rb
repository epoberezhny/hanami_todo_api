require 'shrine/storage/file_system'

case Hanami.env
when 'development', 'production'
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'),
    store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads')
  }
when 'test'
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new('public', prefix: 'test/uploads/cache'),
    store: Shrine::Storage::FileSystem.new('public', prefix: 'test/uploads')
  }
end

Shrine.plugin :hanami
Shrine.plugin :determine_mime_type
Shrine.plugin :parsed_json
Shrine.plugin :delete_raw
Shrine.plugin :default_url_options,
  cache: { host: ENV['HOST'] }, # rubocop:disable Layout/AlignArguments
  store: { host: ENV['HOST'] }
