RSpec.describe TaskRepository, type: :repo do
  subject(:repo) { described_class.new }

  let(:project_1) { Fabricate.create(:project, user_id: user.id) }
  let(:project_2) { Fabricate.create(:project, user_id: user.id) }

  let!(:task_1_1) { Fabricate.create(:task, project_id: project_1.id) }
  let!(:task_1_2) { Fabricate.create(:task, project_id: project_1.id) }
  let!(:task_2_1) { Fabricate.create(:task, project_id: project_2.id) } # rubocop:disable RSpec/LetSetup

  describe 'by_project_id' do
    it 'finds tasks by project_id' do
      expect(repo.by_project_id(project_1.id)).to match_array([task_1_1, task_1_2])
    end
  end

  describe 'find_by_project_id' do
    it 'finds task by project_id and id' do
      expect(repo.find_by_project_id(project_1.id, task_1_1.id)).to eq(task_1_1)
    end
  end

  describe 'count_by_project_id' do
    it 'returns count of tasks by project id' do
      expect(repo.count_by_project_id(project_1.id)).to eq(2)
    end
  end

  describe 'last_position_by_project_id' do
    it 'returns last position of tasks by project id' do
      expect(repo.last_position_by_project_id(project_1.id)).to eq(task_1_2.position)
    end
  end

  describe 'shift_left_from_by_project_id' do
    let!(:task_1_3) { Fabricate.create(:task, project_id: project_1.id) }

    it 'shifts left tasks starting from some position in scope of project' do
      repo.shift_left_from_by_project_id(project_1.id, task_1_2.position)

      expect(repo.find(task_1_1.id).position).to eq(task_1_1.position)
      expect(repo.find(task_1_2.id).position).to eq(task_1_2.position - 1)
      expect(repo.find(task_1_3.id).position).to eq(task_1_3.position - 1)
    end
  end

  describe 'shift_right_from_by_project_id' do
    let!(:task_1_3) { Fabricate.create(:task, project_id: project_1.id) }

    it 'shifts left tasks starting from some position in scope of project' do
      repo.shift_right_from_by_project_id(project_1.id, task_1_2.position)

      expect(repo.find(task_1_1.id).position).to eq(task_1_1.position)
      expect(repo.find(task_1_2.id).position).to eq(task_1_2.position + 1)
      expect(repo.find(task_1_3.id).position).to eq(task_1_3.position + 1)
    end
  end
end
