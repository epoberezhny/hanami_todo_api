RSpec.describe 'Comments', type: :request do
  resource 'Comments' do
    header 'Accept', 'application/json'
    header 'Content-Type', 'application/json'

    authentication :apiKey, :access_token, name: 'Authorization'

    post '/api/v1/projects/:project_id/tasks/:task_id/comments' do
      parameter :text, 'Text of a comment', in: :body
      parameter :attachment, 'Attachment of a comment', in: :body

      let(:project) { Fabricate.create(:project, user_id: user.id) }
      let(:task) { Fabricate.create(:task, project_id: project.id) }
      let(:comment_attrs) { Fabricate.attributes_for(:comment) }

      let(:project_id) { project.id }
      let(:task_id) { task.id }
      let(:raw_post) { comment_attrs.to_json }

      context '201' do
        example_request 'Created' do
          # expect(status).to eq(201)
          expect(response_body).to match_json_schema('api/v1/comment')
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
        let(:comment_attrs) { {} }

        example_request 'Unprocessable' do
          expect(status).to eq(422)
          expect(response_body).to match_json_schema('api/v1/errors')
        end
      end
    end

    get '/api/v1/projects/:project_id/tasks/:task_id/comments' do
      let(:project) { Fabricate.create(:project, user_id: user.id) }
      let(:task) { Fabricate.create(:task, project_id: project.id) }

      before { Fabricate.times(2, :comment, task_id: task.id) }

      let(:project_id) { project.id }
      let(:task_id) { task.id }

      context '200' do
        example_request 'Success' do
          expect(status).to eq(200)
          expect(response_body).to match_json_schema('api/v1/comments')
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

    get '/api/v1/projects/:project_id/tasks/:task_id/comments/:id' do
      let(:project) { Fabricate.create(:project, user_id: user.id) }
      let(:task) { Fabricate.create(:task, project_id: project.id) }
      let(:comment) { Fabricate.create(:comment, task_id: task.id) }

      let(:project_id) { project.id }
      let(:task_id) { task.id }
      let(:id) { comment.id }

      context '200' do
        example_request 'Success' do
          expect(status).to eq(200)
          expect(response_body).to match_json_schema('api/v1/comment')
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

    patch '/api/v1/projects/:project_id/tasks/:task_id/comments/:id' do
      parameter :text, 'Text of a comment', in: :body
      parameter :attachment, 'Attachment of a comment', in: :body

      let(:project) { Fabricate.create(:project, user_id: user.id) }
      let(:task) { Fabricate.create(:task, project_id: project.id) }
      let(:comment) { Fabricate.create(:comment, task_id: task.id) }
      let(:comment_attrs) { Fabricate.attributes_for(:comment, text: 'drugoi text') }

      let(:project_id) { project.id }
      let(:task_id) { task.id }
      let(:id) { comment.id }
      let(:raw_post) { comment_attrs.to_json }

      context '200' do
        example_request 'Success' do
          expect(status).to eq(200)
          expect(response_body).to match_json_schema('api/v1/comment')
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
        let(:comment_attrs) { Fabricate.attributes_for(:invalid_comment) }

        example_request 'Unprocessable' do
          expect(status).to eq(422)
          expect(response_body).to match_json_schema('api/v1/errors')
        end
      end
    end

    delete '/api/v1/projects/:project_id/tasks/:task_id/comments/:id' do
      let(:project) { Fabricate.create(:project, user_id: user.id) }
      let(:task) { Fabricate.create(:task, project_id: project.id) }
      let(:comment) { Fabricate.create(:comment, task_id: task.id) }

      let(:project_id) { project.id }
      let(:task_id) { task.id }
      let(:id) { comment.id }

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
