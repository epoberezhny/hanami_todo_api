RSpec.describe Comments::Operations::Destroy, type: :operation do
  subject(:result) { operation.call(params: {}, user_id: 0) }

  let(:operation) do
    described_class.new(
      project_repo: project_repo, task_repo: task_repo, comment_repo: comment_repo, comment_policy: comment_policy
    )
  end
  let(:project_repo) { instance_double('ProjectRepository', find: project) }
  let(:task_repo) { instance_double('TaskRepository', find_by_project_id: task) }
  let(:comment_repo) { instance_double('CommentRepository', find_by_task_id: comment, delete: comment) }
  let(:comment_policy) { instance_double('Comments::Policy', destroy?: policy_result) }

  let(:project) { Fabricate.build(:project) }
  let(:task) { Fabricate.build(:task) }
  let(:comment) { Fabricate.build(:comment) }
  let(:policy_result) { Success() }

  context 'when comment exists' do
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

  context 'when comment does not exist' do
    let(:comment) { nil }

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
