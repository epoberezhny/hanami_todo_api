RSpec.describe UserRepository, type: :repo do
  subject(:repo) { described_class.new }

  let!(:user_1) { Fabricate.create(:user, password_hash: 'hash') }

  describe 'find_by_username' do
    context 'when user exists' do
      it 'finds user by username' do
        expect(repo.find_by_username(user_1.username)).to eq(user_1)
      end
    end

    context 'when user does not exist' do
      it 'finds user by username' do
        expect(repo.find_by_username('fake_username')).to eq(nil)
      end
    end
  end

  describe 'exists_with_username?' do
    context 'when user exists' do
      it 'returns true' do
        expect(repo.exists_with_username?(user_1.username)).to eq(true)
      end
    end

    context 'when user does not exist' do
      it 'returns false' do
        expect(repo.exists_with_username?('fake_username')).to eq(false)
      end
    end
  end
end
