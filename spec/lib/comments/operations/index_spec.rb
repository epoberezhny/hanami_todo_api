RSpec.describe Comments::Operations::Index, type: :operation do
  subject(:result) { operation.call(params: {}, user_id: 0) }

  let(:operation) do
    described_class.new(
      project_repo: project_repo, task_repo: task_repo, comment_repo: comment_repo, comment_policy: comment_policy
    )
  end
  let(:project_repo) { instance_double('ProjectRepository', find: project) }
  let(:task_repo) { instance_double('TaskRepository', find_by_project_id: task) }
  let(:comment_repo) { instance_double('CommentRepository', by_task_id: comments) }
  let(:comment_policy) { instance_double('Comments::Policy', index?: policy_result) }

  let(:project) { Fabricate.build(:project) }
  let(:task) { Fabricate.build(:task) }
  let(:comments) { Fabricate.build_times(2, :comment) }
  let(:policy_result) { Success() }

  context 'when comments exists' do
    it do
      expect(result).to be_success
      expect(result.value!).to eq(comments)
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

  context 'when policy fails' do
    let(:policy_result) { Failure() }

    it { is_expected.to be_failure }
  end
end
