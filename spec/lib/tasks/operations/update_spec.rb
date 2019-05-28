RSpec.describe Tasks::Operations::Update, type: :operation do
  subject(:result) { operation.call(params: task_attrs) }

  let(:operation) { described_class.new(project_repo: project_repo, task_repo: task_repo) }
  let(:project_repo) { instance_double('ProjectRepository', find: project) }
  let(:task_repo) do
    instance_double(
      'TaskRepository',
      find: task,
      update: task,
      count_by_project_id: 2,
      shift_left_from_by_project_id: 2,
      shift_right_from_by_project_id: 2
    )
  end

  let(:project) { Fabricate.build(:project) }
  let(:task) { Fabricate.build(:task) }
  let(:task_attrs) { Fabricate.attributes_for(:task, position: 2) }

  before do
    allow(task_repo).to receive(:transaction).and_yield
  end

  context 'when payload is valid' do
    it do
      expect(result).to be_success
      expect(result.value!).to eq(task)
    end
  end

  context 'when payload is empty' do
    let(:task_attrs) { {} }

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

  context 'when payload is invalid' do
    let(:task_attrs) { Fabricate.attributes_for(:invalid_task) }

    it do
      expect(result).to be_failure
      expect(result.failure.status).to eq(:unprocessable)
      expect(result.failure.payload).not_to be_empty
    end
  end
end
