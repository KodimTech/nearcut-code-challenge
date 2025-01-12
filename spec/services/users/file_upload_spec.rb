require 'rails_helper'

RSpec.describe ::Users::FileUpload do
  let(:file) { fixture_file_upload('spec/fixtures/files/users.csv') }
  let(:service) { described_class.new(file) }

  describe '#initialize' do
    it 'assigns file' do
      expect(service.file).to eq(file)
    end

    it 'assigns file_result' do
      expect(service.file_result).to eq(Users::FileUpload::FileResults.new([], []))
    end

    it 'assigns valid_rows' do
      expect(service.valid_rows).to eq([])
    end
  end

  describe '#perform' do
    let(:service_result) { service.perform }

    it 'returns file_result' do
      expect(service_result).to eq(service.file_result)
    end

    context 'when file has valid rows' do
      it 'inserts valid users' do
        expect { service.perform }.to change(User, :count).by(1)
      end

      it 'returns valid rows data' do
        expect(service_result.valid_rows).to eq([ { row_number: 1 } ])
      end

      it 'User receives import method' do
        allow(User).to receive(:import)

        service.perform
        expect(User).to have_received(:import).with([ an_instance_of(User) ], validate: false)
      end
    end

    context 'when file has invalid rows' do
      let(:file) { fixture_file_upload('spec/fixtures/files/invalid_users.csv') }

      it 'does not insert invalid users' do
        expect { service.perform }.to change(User, :count).by(0)
      end

      it 'returns invalid rows data' do
        expected_result = [
          { row_number: 1, errors: [ "Password must not include consecutive characters" ] },
          { row_number: 2, errors: [ "Password must be between #{User::PASSWORD_MIN_LENGTH} and #{User::PASSWORD_MAX_LENGTH} characters" ] }
        ]

        expect(service_result.invalid_rows).to eq(expected_result)
      end
    end
  end
end
