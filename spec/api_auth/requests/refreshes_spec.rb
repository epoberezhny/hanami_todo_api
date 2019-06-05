RSpec.describe 'Refresh', type: :request do
  resource 'Refresh' do
    header 'Accept', 'application/json'
    header 'Content-Type', 'application/json'

    post '/api/auth/refresh' do
      parameter 'X_Refresh_Token', in: :header, type: :string, required: true

      before do
        header 'X_Refresh_Token', refresh_token
      end

      context '201' do
        example_request 'Created' do
          expect(status).to eq(201)
          expect(response_body).to match_json_schema('api/auth/tokens')
        end
      end

      context '401' do
        let(:refresh_token) { nil }

        example_request 'Unauthorized' do
          expect(status).to eq(401)
        end
      end
    end
  end
end
