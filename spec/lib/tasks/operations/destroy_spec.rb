RSpec.describe Tasks::Operations::Destroy, type: :operation do
  subject(:result) { operation.call(params: {}) }

  let(:operation) { described_class.new(project_repo: project_repo, task_repo: task_repo) }
  let(:project_repo) { instance_double('ProjectRepository', find: project) }
  let(:task_repo) { instance_double('TaskRepository', find: task, delete: task, shift_left_from_by_project_id: 1) }

  let(:project) { Fabricate.build(:project) }
  let(:task) { Fabricate.build(:task) }

  before do
    allow(task_repo).to receive(:transaction).and_yield
  end

  context 'when task exists' do
    it do
      expect(result).to be_success
    end
  end

  context 'when project does not exist' do
    let(:project) { nil }

    it do
      expect(result).to be_failure
      expect(result.failure.status).to eq(:not_found)
    end
  end

  context 'when task does not exist' do
    let(:task) { nil }

    it do
      expect(result).to be_failure
      expect(result.failure.status).to eq(:not_found)
    end
  end
end
