RSpec.describe Comments::Contracts::Create, type: :dry_validation do
  subject(:contract) { described_class }

  it { is_expected.to validate(:text, :optional).filled.value(min_size: 5, max_size: 50) }
  it { is_expected.to validate(:attachment, :optional) }

  describe 'at_least_one' do
    it 'is invalid' do
      result = contract.call({})
      expect(result.errors[:at_least_one]).to include(I18n.t('errors.at_least_one'))
    end
  end
end
