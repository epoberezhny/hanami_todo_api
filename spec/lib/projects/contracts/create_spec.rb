RSpec.describe Projects::Contracts::Create, type: :dry_validation do
  subject { described_class }

  it { is_expected.to validate(:title, :required).filled.value(max_size: 50) }
end
