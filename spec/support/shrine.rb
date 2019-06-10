RSpec.configure do |config|
  config.after(:suite) do
    Shrine.storages.each_value(&:clear!)
  end
end
