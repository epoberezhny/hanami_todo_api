RSpec.describe Tasks::Operations::Index, type: :operation do
  subject(:result) { operation.call(params: {}, user_id: 0) }

  let(:operation) do
    described_class.new(project_repo: project_repo, task_repo: task_repo, task_policy: task_policy)
  end
  let(:project_repo) { instance_double('ProjectRepository', find: project) }
  let(:task_repo) { instance_double('TaskRepository', by_project_id: tasks) }
  let(:task_policy) { instance_double('Tasks::Policy', index?: policy_result) }

  let(:project) { Fabricate.build(:project) }
  let(:tasks) { Fabricate.build_times(2, :task) }
  let(:policy_result) { Success() }

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

  context 'when policy fails' do
    let(:policy_result) { Failure() }

    it { is_expected.to be_failure }
  end
end
