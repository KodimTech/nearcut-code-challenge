require 'rails_helper'

describe 'User uploads a file', type: :system, driver: :selenium_chrome_headless, js: true do
  let(:file_path) { Rails.root.join('spec', 'fixtures', 'files', 'users.csv') }

  it 'uploads a file' do
    visit root_path

    # Make sure the turbo-frame-tag is present
    expect('#results').to be_present

    # Make sure the form has the right stimulus attributes


    # Make sure the submit button and file input are hidden
    expect(page).to have_css("#submit-button", visible: false)
    expect(page).to have_css("#fileID", visible: false)

    # Click on the choose file button to trigger stimulus action
    choose_file_button = find("#choose-file-button")
    expect(choose_file_button.text).to eq("Choose File")
    expect(choose_file_button['data-components--file-input-target']).to eq("uploadButton")
    expect(choose_file_button['data-action']).to eq("click->components--file-input#fileUpload")
    choose_file_button.click

    file_input = find("#fileID", visible: false)
    file_path = Rails.root.join("spec", "fixtures", "files", "users.csv")
    file_input.attach_file(file_path)

    # Make sure the file input has the correct attributes
    expect(file_input.value).to eq("C:\\fakepath\\users.csv")
    expect(file_input['required']).to eq("true")
    expect(file_input['data-components--file-input-target']).to eq("input")
    expect(choose_file_button.text).to eq("Choose another file")

    # Make sure the submit button is visible now with correct attributes
    submit_button = find("#submit-button", visible: true)
    expect(submit_button['data-components--file-input-target']).to eq("submitButton")
    expect(submit_button['data-action']).to eq("click->components--file-input#submitForm")
    submit_button.click

    form = find("form")
    expect(form['data-controller']).to eq("components--file-input")
    expect(form['data-components--file-input-target']).to eq("form")
  end
end
