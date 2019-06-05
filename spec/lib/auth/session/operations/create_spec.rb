RSpec.describe Auth::Session::Operations::Create, type: :operation do
  subject(:result) { operation.call(params: user_attrs) }

  let(:operation) { described_class.new(user_repo: user_repo) }
  let(:user_repo) { instance_double('UserRepository', find_by_username: user) }

  let(:user_attrs) { Fabricate.attributes_for(:user, password: specific_password) }

  context 'when payload is valid' do
    let(:user) { Fabricate.build(:user, password_hash: password_hash) }
    let(:tokens) { double(:tokens) } # rubocop:disable RSpec/VerifiedDoubles

    it do
      expect(::Auth::Utils::Password).to(
        receive(:compare_password).with(specific_password, password_hash).and_return(true)
      )
      expect(::Auth::Utils::Token).to receive(:generate_tokens).with(user) { tokens }

      expect(result).to be_success
      expect(result.value!).to eq([user, tokens])
    end
  end

  context 'when user does not exist' do
    let(:user) { nil }

    it do
      expect(result).to be_failure
      expect(result.failure.status).to eq(:unauthorized)
    end
  end

  context 'when payload is invalid' do
    it do
      expect(::Auth::Utils::Password).to(
        receive(:compare_password).with(specific_password, password_hash).and_return(false)
      )

      expect(result).to be_failure
      expect(result.failure.status).to eq(:unauthorized)
    end
  end
end
