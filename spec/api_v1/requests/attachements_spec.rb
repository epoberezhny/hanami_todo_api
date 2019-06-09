RSpec.describe 'Attachments', type: :request do
  resource 'Attachments' do
    post '/api/v1/attachments/upload' do
      parameter :file, 'File for attachment', in: :formData, required: true

      let(:file) { Rack::Test::UploadedFile.new('spec/fixtures/files/test.jpg') }

      context '200' do
        example_request 'Success' do
          expect(status).to eq(200)
          expect(response_body).to match_json_schema('api/v1/attachment')
        end
      end
    end
  end
end
