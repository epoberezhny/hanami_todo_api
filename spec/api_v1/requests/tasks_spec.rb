RSpec.describe 'Tasks', type: :request do
  resource 'Tasks' do
    header 'Accept', 'application/json'
    header 'Content-Type', 'application/json'

    authentication :apiKey, :access_token, name: 'Authorization'

    post '/api/v1/projects/:project_id/tasks' do
      parameter :title, 'Title of a task', in: :body, required: true
      parameter :deadline, 'Deadline of a task', in: :body

      let(:project) { Fabricate.create(:project, user_id: user.id) }
      let(:task_attrs) { Fabricate.attributes_for(:task) }

      let(:project_id) { project.id }
      let(:raw_post) { task_attrs.to_json }

      context '201' do
        example_request 'Created' do
          expect(status).to eq(201)
          expect(response_body).to match_json_schema('api/v1/task')
        end
      end

      context '401' do
        let(:access_token) { nil }

        example_request 'Unauthorized' do
          expect(status).to eq(401)
        end
      end

      context '403' do
        let(:another_user) { Fabricate.create(:user, password_hash: 'hash') }
        let(:project) { Fabricate.create(:project, user_id: another_user.id) }

        example_request 'Forbidden' do
          expect(status).to eq(403)
        end
      end

      context '404' do
        let(:project_id) { 0 }

        example_request 'Not found' do
          expect(status).to eq(404)
        end
      end

      context '422' do
        let(:task_attrs) { {} }

        example_request 'Unprocessable' do
          expect(status).to eq(422)
          expect(response_body).to match_json_schema('api/v1/errors')
        end
      end
    end

    get '/api/v1/projects/:project_id/tasks' do
      let(:project) { Fabricate.create(:project, user_id: user.id) }

      before { Fabricate.times(2, :task, project_id: project.id) }

      let(:project_id) { project.id }

      context '200' do
        example_request 'Success' do
          expect(status).to eq(200)
          expect(response_body).to match_json_schema('api/v1/tasks')
        end
      end

      context '401' do
        let(:access_token) { nil }

        example_request 'Unauthorized' do
          expect(status).to eq(401)
        end
      end

      context '403' do
        let(:another_user) { Fabricate.create(:user, password_hash: 'hash') }
        let(:project) { Fabricate.create(:project, user_id: another_user.id) }

        example_request 'Forbidden' do
          expect(status).to eq(403)
        end
      end

      context '404' do
        let(:project_id) { 0 }

        example_request 'Not found' do
          expect(status).to eq(404)
        end
      end
    end

    get '/api/v1/projects/:project_id/tasks/:id' do
      let(:project) { Fabricate.create(:project, user_id: user.id) }
      let(:task) { Fabricate.create(:task, project_id: project.id) }

      let(:project_id) { project.id }
      let(:id) { task.id }

      context '200' do
        example_request 'Success' do
          expect(status).to eq(200)
          expect(response_body).to match_json_schema('api/v1/task')
        end
      end

      context '401' do
        let(:access_token) { nil }

        example_request 'Unauthorized' do
          expect(status).to eq(401)
        end
      end

      context '403' do
        let(:another_user) { Fabricate.create(:user, password_hash: 'hash') }
        let(:project) { Fabricate.create(:project, user_id: another_user.id) }

        example_request 'Forbidden' do
          expect(status).to eq(403)
        end
      end

      context '404' do
        let(:id) { 0 }

        example_request 'Not found' do
          expect(status).to eq(404)
        end
      end
    end

    patch '/api/v1/projects/:project_id/tasks/:id' do
      parameter :title, 'Title of the task', in: :body
      parameter :done, 'Status of the task', in: :body
      parameter :position, 'Position of the task', in: :body
      parameter :deadline, 'Deadline of the task', in: :body

      let(:project) { Fabricate.create(:project, user_id: user.id) }
      let(:task) { Fabricate.create(:task, project_id: project.id) }
      let(:task_attrs) { Fabricate.attributes_for(:task, position: 1) }

      let(:project_id) { project.id }
      let(:id) { task.id }
      let(:raw_post) { task_attrs.to_json }

      context '200' do
        example_request 'Success' do
          expect(status).to eq(200)
          expect(response_body).to match_json_schema('api/v1/task')
        end
      end

      context '401' do
        let(:access_token) { nil }

        example_request 'Unauthorized' do
          expect(status).to eq(401)
        end
      end

      context '403' do
        let(:another_user) { Fabricate.create(:user, password_hash: 'hash') }
        let(:project) { Fabricate.create(:project, user_id: another_user.id) }

        example_request 'Forbidden' do
          expect(status).to eq(403)
        end
      end

      context '404' do
        let(:id) { 0 }

        example_request 'Not found' do
          expect(status).to eq(404)
        end
      end

      context '422' do
        let(:task_attrs) { Fabricate.attributes_for(:invalid_task) }

        example_request 'Unprocessable' do
          expect(status).to eq(422)
          expect(response_body).to match_json_schema('api/v1/errors')
        end
      end
    end

    delete '/api/v1/projects/:project_id/tasks/:id' do
      let(:project) { Fabricate.create(:project, user_id: user.id) }
      let(:task) { Fabricate.create(:task, project_id: project.id) }

      let(:project_id) { project.id }
      let(:id) { task.id }

      context '204' do
        example_request 'No content' do
          expect(status).to eq(204)
        end
      end

      context '401' do
        let(:access_token) { nil }

        example_request 'Unauthorized' do
          expect(status).to eq(401)
        end
      end

      context '403' do
        let(:another_user) { Fabricate.create(:user, password_hash: 'hash') }
        let(:project) { Fabricate.create(:project, user_id: another_user.id) }

        example_request 'Forbidden' do
          expect(status).to eq(403)
        end
      end

      context '404' do
        let(:id) { 0 }

        example_request 'Not found' do
          expect(status).to eq(404)
        end
      end
    end
  end
end
