RSpec.describe Auth::Registration::Contracts::Create, type: :dry_validation do
  subject(:contract) { described_class.with(user_repo: user_repo) }

  let(:user_repo) { instance_double('UserRepository') }

  before do
    allow(user_repo).to receive(:exists_with_username?).and_return(false)
  end

  it { is_expected.to validate(:username, :required).filled.value(min_size: 5, max_size: 50) }
  it { is_expected.to validate(:password, :required).filled.value(min_size: 8, max_size: 50) }

  describe 'username' do
    describe 'unique_username?' do
      let(:user_attrs) { Fabricate.attributes_for(:user) }

      it 'is invalid' do
        expect(user_repo).to receive(:exists_with_username?).and_return(true)

        result = contract.call(user_attrs)

        expect(result.errors[:username]).to include(I18n.t('errors.unique_username?'))
      end
    end
  end
end
