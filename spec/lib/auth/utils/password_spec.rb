RSpec.describe Auth::Utils::Password do
  let(:password) { 'qwerty' }

  describe 'generate_password_hash' do
    it "calls brypt's password create" do
      expect(BCrypt::Password).to receive(:create).with(password)

      described_class.generate_password_hash(password)
    end
  end

  describe 'compare_password' do
    let(:hash) { 'hash' }
    let(:bcrypt_password) { instance_double('BCrypt::Password') }

    it "calls brypt's password equality" do
      expect(BCrypt::Password).to receive(:new).with(hash) { bcrypt_password }
      expect(bcrypt_password).to receive(:==).with(password)

      described_class.compare_password(password, hash)
    end
  end
end
