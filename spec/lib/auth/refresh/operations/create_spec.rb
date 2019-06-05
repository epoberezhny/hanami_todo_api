RSpec.describe Auth::Refresh::Operations::Create, type: :operation do
  subject(:result) { operation.call(refresh_token: refresh_token, payload: extended_payload) }

  let(:operation) { described_class.new }

  let(:tokens) { double(:tokens) } # rubocop:disable RSpec/VerifiedDoubles
  let(:refresh_token) { double(:refresh_token) } # rubocop:disable RSpec/VerifiedDoubles
  let(:payload) { { 'user_id' => 0 } }
  let(:extended_payload) { payload.merge('other_key' => 'other_value') }

  it do
    expect(::Auth::Utils::Token).to receive(:refresh_tokens).with(refresh_token, payload) { tokens }

    expect(result).to be_success
    expect(result.value!).to eq(tokens)
  end
end
