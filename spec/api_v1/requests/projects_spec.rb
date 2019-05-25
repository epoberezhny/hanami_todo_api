RSpec.describe 'Projects', type: :request do
  resource 'Projects' do
    header 'Accept', 'application/json'
    header 'Content-Type', 'application/json'

    post '/api/v1/projects' do
      parameter :title, 'Title of a project', in: :body, required: true

      let(:project_attrs) { Fabricate.attributes_for(:project) }

      context '200' do
        let(:raw_post) { project_attrs.to_json }

        example_request 'Success' do
          expect(status).to eq(201)
          expect(response_body).to match_json_schema('api/v1/project')
        end
      end

      context '422' do
        example_request 'Unprocessable' do
          expect(status).to eq(422)
          expect(response_body).to match_json_schema('api/v1/errors')
        end
      end
    end
  end
end
