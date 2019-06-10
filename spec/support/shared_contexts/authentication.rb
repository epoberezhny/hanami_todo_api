RSpec.shared_context 'authentication' do # rubocop:disable RSpec/ContextWording
  let(:specific_password) { 'qwertyui1' }
  let(:password_hash) { ::Auth::Utils::Password.generate_password_hash(specific_password) }
  let(:user) { Fabricate.create(:user, password_hash: password_hash) }

  let(:tokens) { ::Auth::Utils::Token.generate_tokens(user) }
  let(:access_token) { tokens[:access] }
  let(:refresh_token) { tokens[:refresh] }
end
