RSpec.describe ProjectRepository, type: :repo do
  subject(:repo) { described_class.new }

  describe 'by_user_id' do
    let(:user_1) { Fabricate.create(:user, password_hash: 'hash') }
    let(:user_2) { Fabricate.create(:user, password_hash: 'hash') }

    let!(:project_1_1) { Fabricate.create(:project, user_id: user_1.id) }
    let!(:project_1_2) { Fabricate.create(:project, user_id: user_1.id) }
    let!(:project_2_1) { Fabricate.create(:project, user_id: user_2.id) } # rubocop:disable RSpec/LetSetup

    it 'finds projects by user_id' do
      expect(repo.by_user_id(user_1.id)).to match_array([project_1_1, project_1_2])
    end
  end
end
