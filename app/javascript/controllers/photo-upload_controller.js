import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.dropzone = new Dropzone(this.element, {
      url: this.data.get("url"),
      paramName: 'photo[image]',
      maxFiles: 1,
      headers: {
        "X-CSRF-Token": this.data.get("csrfToken")
      }
    });

    this.dropzone.on("addedfile", (file) => {
      const formData = new FormData();
      formData.append("photo[listing_id]", this.data.get("listingId"));
      formData.append('photo[image]', file);
      this.dropzone.processQueue(formData);
    });

    this.dropzone.on("success", (file, response) => {
      const inputField = document.querySelector("#listing_image_url");
      inputField.value = response.url;
    });
  }

  disconnect() {
    this.dropzone.destroy();
  }
}
