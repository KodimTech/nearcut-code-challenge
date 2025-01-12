import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="components--file-input"
export default class extends Controller {
  static targets = ["form", "input", "dropBox", "header", "uploadButton", "submitButton"]

  fileUpload(e) {
    e.preventDefault()

    const input = this.inputTarget
    const header = this.headerTarget
    const submitButton = this.submitButtonTarget
    const uploadButton = this.uploadButtonTarget

    input.click()

    input.addEventListener("change", (event) => {
      uploadButton.innerHTML = "Choose another file"
      submitButton.style.display = "block"
      header.innerHTML = `Uploaded file: ${event.target.files[0].name}`
    })
  }

    submitForm(event) {
      const submitButton = this.submitButtonTarget
      const form = this.formTarget
      const dropBox = this.dropBoxTarget

      submitButton.addEventListener("click", () => {
        form.submit()

        submitButton.style.display = "none"

        dropBox.innerHTML = `
          <header>
            <h4>File Uploaded Successfully</h4>
          </header>

          <p>Shortly, we will display the results. Thank you!</p>
        `
      })
    }
}
