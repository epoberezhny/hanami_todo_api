RSpec.describe Tasks::Operations::Create, type: :operation do
  subject(:result) { operation.call(params: task_attrs) }

  let(:operation) { described_class.new(project_repo: project_repo, task_repo: task_repo) }
  let(:project_repo) { instance_double('ProjectRepository', find: project) }
  let(:task_repo) { instance_double('TaskRepository', create: task, last_position_by_project_id: 1) }

  let(:task_attrs) { Fabricate.attributes_for(:task) }
  let(:project) { Fabricate.build(:project) }
  let(:task) { Fabricate.build(:task, task_attrs) }

  context 'when payload is valid' do
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

  context 'when payload is invalid' do
    let(:task_attrs) { {} }

    it do
      expect(result).to be_failure
      expect(result.failure.status).to eq(:unprocessable)
      expect(result.failure.payload).not_to be_empty
    end
  end
end
