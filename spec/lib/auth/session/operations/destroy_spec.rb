RSpec.describe Auth::Session::Operations::Destroy, type: :operation do
  subject(:result) { operation.call(refresh_token: refresh_token) }

  let(:operation) { described_class.new }

  let(:refresh_token) { double(:refresh_token) } # rubocop:disable RSpec/VerifiedDoubles

  it do
    expect(::Auth::Utils::Token).to receive(:flush_session).with(refresh_token)

    expect(result).to be_success
  end
end
