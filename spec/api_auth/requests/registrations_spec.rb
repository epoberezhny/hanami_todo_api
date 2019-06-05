RSpec.describe 'Registration', type: :request do
  resource 'Registration' do
    header 'Accept', 'application/json'
    header 'Content-Type', 'application/json'

    post '/api/auth/registration' do
      parameter :username, 'Username', in: :body, required: true
      parameter :password, 'Password', in: :body, required: true
      parameter :password_confirmation, 'Password confirmation', in: :body, required: true

      let(:user_attrs) do
        Fabricate.attributes_for(:user).merge(password: specific_password, password_confirmation: specific_password)
      end

      context '201' do
        let(:raw_post) { user_attrs.to_json }

        example_request 'Created' do
          expect(status).to eq(201)
          expect(response_body).to match_json_schema('api/auth/registration')
        end
      end

      context '422' do
        example_request 'Unprocessable' do
          expect(status).to eq(422)
          expect(response_body).to match_json_schema('api/auth/errors')
        end
      end
    end
  end
end
