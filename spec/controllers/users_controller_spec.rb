require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:file) { fixture_file_upload('spec/fixtures/files/users.csv') }

  before do
    allow(Users::FileUpload).to receive(:new).and_call_original
    allow(::Forms::FileUpload::ResultsComponent).to receive(:new).and_call_original
  end

  describe 'POST #create' do
    it 'triggers Users::FileUpload class' do
      post '/users', params: { file: file }

      expect(Users::FileUpload).to have_received(:new).with(an_instance_of(ActionDispatch::Http::UploadedFile))
    end

    it 'renders turbo_stream' do
      post '/users', params: { file: file }

      expect(response.body).to include('turbo-stream')
    end

    it 'renders results component' do
      post '/users', params: { file: file }
      expect(::Forms::FileUpload::ResultsComponent).to have_received(:new)
    end
  end
end
