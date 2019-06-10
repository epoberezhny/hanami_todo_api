RSpec.describe Auth::Registration::Operations::Create, type: :operation do
  subject(:result) { operation.call(params: user_attrs) }

  let(:operation) { described_class.new(user_repo: user_repo) }
  let(:user_repo) { instance_double('UserRepository', create: user, exists_with_username?: false) }

  let(:user_attrs) do
    Fabricate.attributes_for(:user, password: specific_password, password_confirmation: specific_password)
  end
  let(:user) { Fabricate.build(:user) }

  context 'when payload is valid' do
    let(:tokens) { double(:tokens) } # rubocop:disable RSpec/VerifiedDoubles

    it do
      expect(::Auth::Utils::Password).to receive(:generate_password_hash).with(specific_password)
      expect(::Auth::Utils::Token).to receive(:generate_tokens).with(user) { tokens }

      expect(result).to be_success
      expect(result.value!).to eq([user, tokens])
    end
  end

  context 'when payload is invalid' do
    let(:user_attrs) { {} }

    it do
      expect(result).to be_failure
      expect(result.failure.status).to eq(:unprocessable)
      expect(result.failure.payload).not_to be_empty
    end
  end
end
