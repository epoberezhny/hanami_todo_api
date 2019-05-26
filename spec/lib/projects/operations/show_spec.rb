RSpec.describe Projects::Operations::Show, type: :operation do
  subject(:result) { operation.call(params: {}) }

  let(:operation) { described_class.new(repository: project_repo) }
  let(:project_repo) { instance_double('ProjectRepository', find: project) }

  context 'when project exists' do
    let(:project) { Fabricate.build(:project) }

    it do
      expect(result).to be_success
      expect(result.value!).to eq(project)
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
