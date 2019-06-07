RSpec.describe Comments::Contracts::Update, type: :dry_validation do
  subject{ described_class }

  it { is_expected.to validate(:text, :optional).filled.value(min_size: 5, max_size: 50) }
  it { is_expected.to validate(:attachment, :optional).filled(:hash) }
end
