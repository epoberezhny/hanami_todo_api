RSpec.describe Tasks::Operations::Show, type: :operation do
  subject(:result) { operation.call(params: {}) }

  let(:operation) { described_class.new(project_repo: project_repo, task_repo: task_repo) }
  let(:project_repo) { instance_double('ProjectRepository', find: project) }
  let(:task_repo) { instance_double('TaskRepository', find: task) }

  let(:project) { Fabricate.build(:project) }
  let(:task) { Fabricate.build(:task) }

  context 'when task exists' do
    it do
      expect(result).to be_success
      expect(result.value!).to eq(task)
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
