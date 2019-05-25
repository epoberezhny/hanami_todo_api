RSpec.describe Projects::Operations::Create, type: :operation do
  subject(:result) { operation.call(params: project_attrs) }

  let(:operation) { described_class.new(repository: project_repo, policy: project_policy) }
  let(:project_policy) { instance_double('Projects::Policy', create?: true) }
  let(:project_repo) { instance_double('ProjectRepository', create: Project.new) }

  let(:project_attrs) { Fabricate.attributes_for(:project) }

  context 'when payload is valid' do
    it do
      expect(result).to be_success
      expect(result.value!).to be_a(Project)
    end
  end

  context 'when create is forbidden' do
    let(:project_policy) { instance_double('Projects::Policy', create?: false) }

    it do
      expect(result).to be_failure
      expect(result.failure.status).to eq(:forbidden)
    end
  end

  context 'when payload is invalid' do
    let(:project_attrs) { {} }

    it do
      expect(result).to be_failure
      expect(result.failure.status).to eq(:unprocessable)
      expect(result.failure.payload).not_to be_empty
    end
  end
end
