RSpec.describe CommentRepository, type: :repo do
  subject(:repo) { described_class.new }

  let(:project) { Fabricate.create(:project, user_id: user.id) }

  let!(:task_1) { Fabricate.create(:task, project_id: project.id) }
  let!(:task_2) { Fabricate.create(:task, project_id: project.id) }

  let!(:comment_1_1) { Fabricate.create(:comment, task_id: task_1.id) }
  let!(:comment_1_2) { Fabricate.create(:comment, task_id: task_1.id) }
  let!(:comment_2_1) { Fabricate.create(:comment, task_id: task_2.id) } # rubocop:disable RSpec/LetSetup

  describe 'by_task_id' do
    it 'finds comments by task_id' do
      expect(repo.by_task_id(task_1.id)).to match_array([comment_1_1, comment_1_2])
    end
  end

  describe 'find_by_task_id' do
    it 'finds comment by task_id and id' do
      expect(repo.find_by_task_id(task_1.id, comment_1_1.id)).to eq(comment_1_1)
    end
  end
end
