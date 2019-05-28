RSpec.describe Tasks::Contracts::Create, type: :dry_validation do
  subject { described_class }

  it { is_expected.to validate(:title, :required).filled.value(min_size: 5, max_size: 50) }
end
