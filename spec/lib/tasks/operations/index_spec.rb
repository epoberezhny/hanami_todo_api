RSpec.describe Tasks::Operations::Index, type: :operation do
  subject(:result) { operation.call(params: {}) }

  let(:operation) { described_class.new(project_repo: project_repo, task_repo: task_repo) }
  let(:project_repo) { instance_double('ProjectRepository', find: project) }
  let(:task_repo) { instance_double('TaskRepository', by_project_id: tasks) }

  let(:project) { Fabricate.build(:project) }
  let(:tasks) { Fabricate.build_times(2, :task) }

  context 'when tasks exists' do
    it do
      expect(result).to be_success
      expect(result.value!).to eq(tasks)
    end
  end

  context 'when project does not exist' do
    let(:project) { nil }

    it do
      expect(result).to be_failure
      expect(result.failure.status).to eq(:not_found)
    end
  end
end
