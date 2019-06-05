RSpec.describe Projects::Operations::Index, type: :operation do
  subject(:result) { operation.call(user_id: 0) }

  let(:operation) { described_class.new(project_repo: project_repo) }
  let(:project_repo) { instance_double('ProjectRepository', by_user_id: projects) }

  let(:projects) { Fabricate.build_times(2, :project) }

  context 'when projects exists' do
    it do
      expect(result).to be_success
      expect(result.value!).to eq(projects)
    end
  end
end
