RSpec.describe Projects::Contracts::Update, type: :dry_validation do
  subject { described_class }

  it { is_expected.to validate(:title, :optional).filled.value(min_size: 5, max_size: 50) }
end
