RSpec.describe 'Projects', type: :request do
  resource 'Projects' do
    header 'Accept', 'application/json'
    header 'Content-Type', 'application/json'

    authentication :apiKey, :access_token, name: 'Authorization'

    post '/api/v1/projects' do
      parameter :title, 'Title of a project', in: :body, required: true

      let(:project_attrs) { Fabricate.attributes_for(:project) }

      context '201' do
        let(:raw_post) { project_attrs.to_json }

        example_request 'Created' do
          expect(status).to eq(201)
          expect(response_body).to match_json_schema('api/v1/project')
        end
      end

      context '401' do
        let(:access_token) { nil }

        example_request 'Unauthorized' do
          expect(status).to eq(401)
        end
      end

      context '422' do
        example_request 'Unprocessable' do
          expect(status).to eq(422)
          expect(response_body).to match_json_schema('api/v1/errors')
        end
      end
    end

    get '/api/v1/projects' do
      before { Fabricate.times(2, :project, user_id: user.id) }

      context '200' do
        example_request 'Success' do
          expect(status).to eq(200)
          expect(response_body).to match_json_schema('api/v1/projects')
        end
      end

      context '401' do
        let(:access_token) { nil }

        example_request 'Unauthorized' do
          expect(status).to eq(401)
        end
      end
    end

    get '/api/v1/projects/:id' do
      let(:project) { Fabricate.create(:project, user_id: user.id) }

      let(:id) { project.id }

      context '200' do
        example_request 'Success' do
          expect(status).to eq(200)
          expect(response_body).to match_json_schema('api/v1/project')
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

    patch '/api/v1/projects/:id' do
      parameter :title, 'Title of the project', in: :body

      let(:project) { Fabricate.create(:project, user_id: user.id) }
      let(:project_attrs) { Fabricate.attributes_for(:project) }

      let(:id) { project.id }
      let(:raw_post) { project_attrs.to_json }

      context '200' do
        example_request 'Success' do
          expect(status).to eq(200)
          expect(response_body).to match_json_schema('api/v1/project')
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
        let(:project_attrs) { Fabricate.attributes_for(:invalid_project) }

        example_request 'Unprocessable' do
          expect(status).to eq(422)
          expect(response_body).to match_json_schema('api/v1/errors')
        end
      end
    end

    delete '/api/v1/projects/:id' do
      let(:project) { Fabricate.create(:project, user_id: user.id) }

      let(:id) { project.id }

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
