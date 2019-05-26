RSpec.describe Projects::Operations::Create, type: :operation do
  subject(:result) { operation.call(params: project_attrs) }

  let(:operation) { described_class.new(repository: project_repo) }
  let(:project_repo) { instance_double('ProjectRepository', create: project) }

  let(:project_attrs) { Fabricate.attributes_for(:project) }
  let(:project) { Fabricate.build(:project, project_attrs) }

  context 'when payload is valid' do
    it do
      expect(result).to be_success
      expect(result.value!).to eq(project)
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
