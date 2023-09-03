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
      this.flashMessage("Upload successful!", "success");
    });

    this.dropzone.on("error", (file, errorMessage) => {
      this.flashMessage(errorMessage, "error");
    });
  }

  disconnect() {
    this.dropzone.destroy();
  }

  flashMessage(message, type = "success") {
    const alertDiv = document.getElementById("alert");
  
    alertDiv.className = "py-2 px-3 mb-5 font-medium rounded-lg inline-block";
  
    let duration; // Variable to hold the duration the message should stay on screen
  
    if (type === "success") {
      alertDiv.classList.add("bg-green-50", "text-green-500");
      duration = 5000;
    } else if (type === "error") {
      alertDiv.classList.add("bg-red-50", "text-red-500");
      duration = 10000; 
    }
  
    alertDiv.textContent = message;
    alertDiv.classList.remove("hidden");
  
    setTimeout(() => {
      alertDiv.classList.add("hidden");
    }, duration);
  }
}
