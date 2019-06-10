RSpec.describe Auth::Utils::Token do
  let(:session) { instance_double('JWTSessions::Session') }
  let(:tokens) { double(:tokens) } # rubocop:disable RSpec/VerifiedDoubles
  let(:user) { Fabricate.build(:user, id: 0) }
  let(:payload) { { user_id: user.id } }
  let(:refresh_token) { double(:refresh_token) } # rubocop:disable RSpec/VerifiedDoubles

  describe 'generate_tokens' do
    it "uses jwt session's login" do
      expect(JWTSessions::Session).to receive(:new).with(payload: payload, refresh_payload: payload) { session }
      expect(session).to receive(:login) { tokens }

      result = described_class.generate_tokens(user)
      expect(result).to eq(tokens)
    end
  end

  describe 'refresh_tokens' do
    it "uses jwt session's refresh" do
      expect(JWTSessions::Session).to receive(:new).with(payload: payload, refresh_payload: payload) { session }
      expect(session).to receive(:refresh) { tokens }

      result = described_class.refresh_tokens(refresh_token, payload)
      expect(result).to eq(tokens)
    end
  end

  describe 'flush_session' do
    let(:expected_result) { 1 }

    it "uses jwt session's refresh" do
      expect(JWTSessions::Session).to receive(:new).with(no_args) { session }
      expect(session).to receive(:flush_by_token) { expected_result }

      result = described_class.flush_session(refresh_token)
      expect(result).to eq(expected_result)
    end
  end
end
