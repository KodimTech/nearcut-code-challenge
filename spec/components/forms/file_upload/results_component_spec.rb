# frozen_string_literal: true

require "rails_helper"

RSpec.describe Forms::FileUpload::ResultsComponent, type: :component do
  let(:file) { fixture_file_upload('spec/fixtures/files/users.csv') }
  let(:file_upload_service) { Users::FileUpload.new(file) }
  let(:results) { file_upload_service.perform }

  before do
    render_inline(described_class.new(results: results))
  end

  it 'renders the component' do
    expect(page).to have_css("h3", text: "Uploaded file results")
  end

  context 'when file has valid rows' do
    it 'displays valid rows results' do
      expect(page).to have_css("h3", text: "Valid rows count: #{results.valid_rows.size}")

      results.valid_rows.each do |row|
        expect(page).to have_css("span", text: "Row number: #{row[:row_number]}")
      end
    end
  end

  context 'when file has invalid rows' do
    it 'displays valid rows results' do
      expect(page).to have_css("h3", text: "Invalid rows count: #{results.invalid_rows.size}")

      results.invalid_rows.each do |row|
        expect(page).to have_css("span",
                                 text: "Row number: #{row[:row_number]}, Error(s): #{row[:errors].join(', ')}")
      end
    end
  end
end
