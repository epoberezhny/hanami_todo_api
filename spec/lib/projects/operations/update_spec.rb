RSpec.describe Projects::Operations::Update, type: :operation do
  subject(:result) { operation.call(params: project_attrs, user_id: 0) }

  let(:operation) { described_class.new(project_repo: project_repo, project_policy: project_policy) }
  let(:project_repo) { instance_double('ProjectRepository', find: project, update: updated_project) }
  let(:project_policy) { instance_double('Projects::Policy', update?: policy_result) }

  let(:project_attrs) { Fabricate.attributes_for(:project) }
  let(:project) { Fabricate.build(:project) }
  let(:updated_project) { Fabricate.build(:project, project_attrs) }
  let(:policy_result) { Success() }

  context 'when payload is valid' do
    it do
      expect(result).to be_success
      expect(result.value!).to eq(updated_project)
    end
  end

  context 'when payload is empty' do
    let(:project_attrs) { {} }

    it do
      expect(result).to be_success
      expect(result.value!).to eq(updated_project)
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
    let(:project_attrs) { Fabricate.attributes_for(:invalid_project) }

    it do
      expect(result).to be_failure
      expect(result.failure.status).to eq(:unprocessable)
      expect(result.failure.payload).not_to be_empty
    end
  end

  context 'when policy fails' do
    let(:policy_result) { Failure() }

    it { is_expected.to be_failure }
  end
end
