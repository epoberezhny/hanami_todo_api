RSpec.describe Tasks::Contracts::Update, type: :dry_validation do
  subject(:contract) { described_class.with(task_repo: task_repo, project_id: project_id) }

  let(:project_id) { 0 }
  let(:task_repo) { instance_double('TaskRepository') }

  before do
    allow(task_repo).to receive(:count_by_project_id).with(project_id).and_return(10)
  end

  it { is_expected.to validate(:title, :optional).filled.value(min_size: 5, max_size: 50) }
  it { is_expected.to validate(:done, :optional).filled(:bool) }
  it { is_expected.to validate(:position, :optional).filled(:int) }

  describe 'position' do
    describe 'valid_position?' do
      it 'is  invalid' do
        result = contract.call(position: 11)

        expect(task_repo).to have_received(:count_by_project_id).with(project_id)
        expect(result.errors[:position]).to include(I18n.t('errors.valid_position?'))
      end
    end

    describe 'gt?' do
      let(:min) { 0 }

      it 'is  invalid' do
        result = contract.call(position: min)
        expect(result.errors[:position]).to include(I18n.t('errors.gt?', num: min))
      end
    end
  end
end
