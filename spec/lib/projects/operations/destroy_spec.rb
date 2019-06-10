RSpec.describe Projects::Operations::Destroy, type: :operation do
  subject(:result) { operation.call(params: {}, user_id: 0) }

  let(:operation) { described_class.new(project_repo: project_repo, project_policy: project_policy) }
  let(:project_repo) { instance_double('ProjectRepository', find: project, delete: project) }
  let(:project_policy) { instance_double('Projects::Policy', destroy?: policy_result) }

  let(:project) { Fabricate.build(:project) }
  let(:policy_result) { Success() }

  context 'when project exists' do
    it { is_expected.to be_success }
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
