RSpec.describe Projects::Operations::Update, type: :operation do
  subject(:result) { operation.call(params: project_attrs) }

  let(:operation) { described_class.new(repository: project_repo) }
  let(:project_repo) { instance_double('ProjectRepository', find: project, update: updated_project) }

  let(:project_attrs) { Fabricate.attributes_for(:project) }
  let(:project) { Fabricate.build(:project) }
  let(:updated_project) { Fabricate.build(:project, project_attrs) }

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
end
