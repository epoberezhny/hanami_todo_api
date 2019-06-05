RSpec.describe Projects::Policy, type: :policy do
  describe 'show?' do
    subject(:result) { described_class.new.show?(project, user.id) }

    let(:user) { Fabricate.build(:user, id: 1) }

    context 'when user is project owner' do
      let(:project) { Fabricate.build(:project, user_id: user.id) }

      it { is_expected.to be_success }
    end

    context 'when user does not project owner' do
      let(:project) { Fabricate.build(:project, user_id: 0) }

      it do
        expect(result).to be_failure
        expect(result.failure.status).to eq(:forbidden)
      end
    end
  end

  describe 'update?' do
    subject(:result) { described_class.new.update?(project, user.id) }

    let(:user) { Fabricate.build(:user, id: 1) }

    context 'when user is project owner' do
      let(:project) { Fabricate.build(:project, user_id: user.id) }

      it { is_expected.to be_success }
    end

    context 'when user does not project owner' do
      let(:project) { Fabricate.build(:project, user_id: 0) }

      it do
        expect(result).to be_failure
        expect(result.failure.status).to eq(:forbidden)
      end
    end
  end

  describe 'destroy?' do
    subject(:result) { described_class.new.destroy?(project, user.id) }

    let(:user) { Fabricate.build(:user, id: 1) }

    context 'when user is project owner' do
      let(:project) { Fabricate.build(:project, user_id: user.id) }

      it { is_expected.to be_success }
    end

    context 'when user does not project owner' do
      let(:project) { Fabricate.build(:project, user_id: 0) }

      it do
        expect(result).to be_failure
        expect(result.failure.status).to eq(:forbidden)
      end
    end
  end
end
