RSpec.describe 'Session', type: :request do
  resource 'Session' do
    header 'Accept', 'application/json'
    header 'Content-Type', 'application/json'

    post '/api/auth/session' do
      parameter :username, 'Username', in: :body, required: true
      parameter :password, 'Password', in: :body, required: true

      let(:user_attrs) { { username: user.username, password: specific_password } }

      context '201' do
        let(:raw_post) { user_attrs.to_json }

        example_request 'Created' do
          expect(status).to eq(201)
          expect(response_body).to match_json_schema('api/auth/session')
        end
      end

      context '401' do
        example_request 'Unauthorized' do
          expect(status).to eq(401)
        end
      end
    end

    get '/api/auth/session' do
      authentication :apiKey, :access_token, name: 'Authorization'

      context '200' do
        example_request 'Success' do
          expect(status).to eq(200)
          expect(response_body).to match_json_schema('api/auth/user')
        end
      end

      context '401' do
        let(:access_token) { nil }

        example_request 'Unauthorized' do
          expect(status).to eq(401)
        end
      end
    end

    delete '/api/auth/session' do
      parameter 'X_Refresh_Token', in: :header, type: :string, required: true

      before do
        header 'X_Refresh_Token', refresh_token
      end

      context '204' do
        example_request 'No Content' do
          expect(status).to eq(204)
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
