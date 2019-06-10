RSpec.describe Auth::Session::Operations::Show, type: :operation do
  subject(:result) { operation.call(payload: payload) }

  let(:operation) { described_class.new(user_repo: user_repo) }
  let(:user_repo) { instance_double('UserRepository', find: user) }

  let(:payload) { { 'user_id' => 0 } }

  context 'when user exists' do
    let(:user) { Fabricate.build(:user) }

    it do
      expect(result).to be_success
      expect(result.value!).to eq(user)
    end
  end

  context 'when user does not exist' do
    let(:user) { nil }

    it do
      expect(result).to be_failure
      expect(result.failure.status).to eq(:not_found)
    end
  end
end
